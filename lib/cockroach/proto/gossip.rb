# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: cockroach/proto/gossip.proto

require 'google/protobuf'

require 'cockroach/proto/config'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "cockroach.proto.GossipRequest" do
    optional :node_id, :int32, 1
    optional :addr, :message, 2, "cockroach.proto.Addr"
    optional :l_addr, :message, 3, "cockroach.proto.Addr"
    optional :max_seq, :int64, 4
    optional :delta, :string, 5
  end
  add_message "cockroach.proto.GossipResponse" do
    optional :delta, :string, 1
    optional :alternate, :message, 2, "cockroach.proto.Addr"
  end
end

module Cockroach
  module Proto
    GossipRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("cockroach.proto.GossipRequest").msgclass
    GossipResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("cockroach.proto.GossipResponse").msgclass
  end
end
