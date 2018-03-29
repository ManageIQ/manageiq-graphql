module ManageIQ
  module GraphQL
    module Types
      HostVmware = ::GraphQL::ObjectType.define do
        name "HostVmware"
        implements ::GraphQL::Relay::Node.interface
        interfaces [Taggable, Host]
      end
    end
  end
end
