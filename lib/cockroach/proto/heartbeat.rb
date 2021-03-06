# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: cockroach/proto/heartbeat.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "cockroach.proto.RemoteOffset" do
    optional :offset, :int64, 1
    optional :error, :int64, 2
    optional :measured_at, :int64, 3
  end
  add_message "cockroach.proto.PingRequest" do
    optional :ping, :string, 1
    optional :offset, :message, 2, "cockroach.proto.RemoteOffset"
    optional :addr, :string, 3
  end
  add_message "cockroach.proto.PingResponse" do
    optional :pong, :string, 1
    optional :server_time, :int64, 2
  end
end

module Cockroach
  module Proto
    RemoteOffset = Google::Protobuf::DescriptorPool.generated_pool.lookup("cockroach.proto.RemoteOffset").msgclass
    PingRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("cockroach.proto.PingRequest").msgclass
    PingResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("cockroach.proto.PingResponse").msgclass
  end
end
