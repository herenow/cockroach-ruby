require('api_pb2')

class Methods
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
	Contains = self.class.new("Contains", false, api_pb2.ContainsRequest, api_pb2.ContainsResponse)
	Get = self.class.new("Get", false, api_pb2.GetRequest, api_pb2.GetResponse)
	Put = self.class.new("Put", true, api_pb2.PutRequest, api_pb2.PutResponse)
	ConditionalPut = self.class.new("ConditionalPut", true, api_pb2.ConditionalPutRequest, api_pb2.ConditionalPutResponse)
	Increment = self.class.new("Increment", true, api_pb2.IncrementRequest, api_pb2.IncrementResponse)
	Delete = self.class.new("Delete", true, api_pb2.DeleteRequest, api_pb2.DeleteResponse)
	DeleteRange = self.class.new("DeleteRange", true, api_pb2.DeleteRangeRequest, api_pb2.DeleteRangeResponse)
	Scan = self.class.new("Scan", false, api_pb2.ScanRequest, api_pb2.ScanResponse)
	EndTransaction = self.class.new("EndTransaction", true, api_pb2.EndTransactionRequest, api_pb2.EndTransactionResponse)
	ReapQueue = self.class.new("ReapQueue", true, api_pb2.ReapQueueRequest, api_pb2.ReapQueueResponse)
	EnqueueUpdate = self.class.new("EnqueueUpdate", true, api_pb2.EnqueueUpdateRequest, api_pb2.EnqueueUpdateResponse)
	EnqueueMessage = self.class.new("EnqueueMessage", true, api_pb2.EnqueueMessageRequest, api_pb2.EnqueueMessageResponse)
	Batch = self.class.new("Batch", true, api_pb2.BatchRequest, api_pb2.BatchResponse)
	AdminSplit = self.class.new("AdminSplit", false, api_pb2.AdminSplitRequest, api_pb2.AdminSplitResponse)
end
