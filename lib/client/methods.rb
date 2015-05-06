require "../cockroach/proto/api"

# Reference the proto namespace, just in case it changes
Proto = Cockroach::Proto

class Methods
  attr_reader :method, :is_write, :request_type, :response_type

  """Constants defining RPC methods.
  Each has the following attributes:
  * name
  * is_write
  * request_type
  * response_type
  """
  def initialize(method, is_write, request_type, response_type)
    @method = method
    @is_write = is_write
    @request_type = request_type
    @response_type = response_type
  end

  def to_s
    @method
  end

  # This list only includes the public methods from cockroach/proto/api.go
  # Note that capitalization of the names matters as it is used for the
  # RPC names on the wire.
  Contains = self.class.new("Contains", false, Proto::ContainsRequest, Proto::ContainsResponse)
  Get = self.class.new("Get", false, Proto::GetRequest, Proto::GetResponse)
  Put = self.class.new("Put", true, Proto::PutRequest, Proto::PutResponse)
  ConditionalPut = self.class.new("ConditionalPut", true, Proto::ConditionalPutRequest, Proto::ConditionalPutResponse)
  Increment = self.class.new("Increment", true, Proto::IncrementRequest, Proto::IncrementResponse)
  Delete = self.class.new("Delete", true, Proto::DeleteRequest, Proto::DeleteResponse)
  DeleteRange = self.class.new("DeleteRange", true, Proto::DeleteRangeRequest, Proto::DeleteRangeResponse)
  Scan = self.class.new("Scan", false, Proto::ScanRequest, Proto::ScanResponse)
  EndTransaction = self.class.new("EndTransaction", true, Proto::EndTransactionRequest, Proto::EndTransactionResponse)
  ReapQueue = self.class.new("ReapQueue", true, Proto::ReapQueueRequest, Proto::ReapQueueResponse)
  EnqueueUpdate = self.class.new("EnqueueUpdate", true, Proto::EnqueueUpdateRequest, Proto::EnqueueUpdateResponse)
  EnqueueMessage = self.class.new("EnqueueMessage", true, Proto::EnqueueMessageRequest, Proto::EnqueueMessageResponse)
  Batch = self.class.new("Batch", true, Proto::BatchRequest, Proto::BatchResponse)
  AdminSplit = self.class.new("AdminSplit", false, Proto::AdminSplitRequest, Proto::AdminSplitResponse)
end
