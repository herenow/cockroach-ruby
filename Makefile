proto:
	protoc --ruby_out=lib --proto_path=cockroach-proto cockroach-proto/cockroach/proto/*.proto
