module ManageIQ
  module GraphQL
    module Types
      VmVmware = ::GraphQL::ObjectType.define do
        name "VmVmware"
        implements ::GraphQL::Relay::Node.interface
        interfaces [Taggable, Vm]
      end
    end
  end
end
