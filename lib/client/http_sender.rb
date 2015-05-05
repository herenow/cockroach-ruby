require 'uri'
require 'net/http'
require 'protobuf'

class HTTPSender
  # KVDBEndpoint is the URL path prefix which accepts incoming
  # HTTP requests for the KV API.
  KVDB_ENDPOINT = "/kv/db/"
  # KVDBScheme is the scheme for connecting to the kvdb endpoint.
  # TODO(spencer): change this to CONSTANT https. We shouldn't be
  # supporting http here at all.
  KVDB_SCHEME = "http"
  # StatusTooManyRequests indicates client should retry due to
  # server having too many requests.
  STATUS_TOO_MANY_REQUESTS = 429
  # Gem version
  VERSION = Gem.loaded_specs["cockroach-ruby"].version || 'Unknown'
  # User-agent
  USER_AGENT = 'cockroach-ruby v' + version
  # HTTPRetryOptions sets the retry options for handling retryable
  # HTTP errors and connection I/O errors.
  HTTP_RETRY_OPTIONS = {
    :backoff =>     50, # ms
    :maxBackoff =>  5 * 1000,
    :constant =>    2,
    :maxAttempts => 0   # retry indefinitely
  }


  # httpSendError wraps any error returned when sending an HTTP request
  # in order to signal the retry loop that it should backoff and retry.
  class HttpSendError < StandardError
  end

  # HTTPSender is an implementation of KVSender which exposes the
  # Key-Value database provided by a Cockroach cluster by connecting
  # via HTTP to a Cockroach node. Overly-busy nodes will redirect
  # this client to other nodes.
  def initialize(opts = {})
    if opts.host && opts.port
      @host = opts.host
      @port = opts.port
    elsif opts.uri
      uri = URI(opts.uri)
      @host = uri.host
      @port = uri.port || 80
    else
      raise "failed to create http_sender, no endpoint was specified."
    end

    @http = opts.http || Net::HTTP
  end


  # Send sends call to Cockroach via an HTTP post. HTTP response codes
  # which are retryable are retried with backoff in a loop using the
  # default retry options. Other errors sending HTTP request are
  # retried indefinitely using the same client command ID to avoid
  # reporting failure when in fact the command may have gone through
  # and been executed successfully. We retry here to eventually get
  # through with the same client command ID and be given the cached
  # response.
  def send(call)

  end

  # post posts the call using the HTTP client. The call's method is
  # appended to KVDBEndpoint and set as the URL path. The call's arguments
  # are protobuf-serialized and written as the POST body. The content
  # type is set to application/x-protobuf.
  #
  # On success, the response body is unmarshalled into call.Reply.
  def post(call)
    opts = {
        :method => 'POST',
        :path => KVDB_ENDPOINT + call.Method,
        :host => @host,
        :port => @port,
        :headers => {
            "User-Agent" => USER_AGENT,
            "Content-Type" => 'application/x-protobuf',
            "Accept" => 'application/x-protobuf'
        }
    }
    """
    var body = call.Request.toBuffer()

    var req = this.http.request(opts, function(res) {
        if(res.statusCode !== 200) {
            callback(
                new Error('received status code '+res.statusCode+' from kv db endpoint.')
            )
            return
        }

        res.setEncoding('base64')

        var data = ''

        res.on('data', function(chunk) {
            data += chunk
        })

        res.on('end', function() {
            try {
                var builder = proto.GetResponseBuilder(call.Method)
                var response = builder.decode(data, 'base64')
            } catch(e) {
                callback(
                    new Error('failed to parse response from kv db endpoint ('+e.message+')'),
                    null
                )
                throw e
                return
            }

            callback(null, response)
        })
    })

        req.on('error', function(err) {
            callback(new HttpSendError(err))
        })

    req.write(body)
    req.end()
    """
  end

  private send

end

