require 'protobuf/message'

class Call

  # A Call is a pending database API call.
  def initialize(call)
    # Type-check
    unless call.method.is_a? String
      raise "method should be of type string"
    end
    unless call.request.is_a? ProtoBuf::Message
      raise "request should be a instance of a protocol message"
    end

    @method = call.method   # The name of the database command (see api.proto)
    @request = call.request  # The argument to the command
  end

  # resetClientCmdID sets the client command ID if the call is for a
  # read-write method. The client command ID provides idempotency
  # protection in conjunction with the server.
  def reset_client_cmd_id
    # On mutating commands, set a client command ID. This prevents
    # mutations from being run multiple times on retries.
    if proto.WriteMethods.include? @method
        @request.getHeader.set('cmd_id', proto.ClientCmdID.new({
            wall_time: now(clock),
            # Note: 9223372036854775807 is the range of a positive int64)
            random: Rand.new.rand(9223372036854775807)
        }))
    end
  end

  private

  # now returns clock.Now() if clock is not nil; otherwise uses the
  # system wall time.
  def now(clock = nil)
    unless clock
      Time.now.nsec
    else
      clock.now
    end
  end
end
