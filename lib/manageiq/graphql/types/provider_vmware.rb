module ManageIQ
  module GraphQL
    module Types
      ProviderVmware = ::GraphQL::ObjectType.define do
        name "ProviderVmware"
        implements ::GraphQL::Relay::Node.interface
        interfaces [Taggable, Provider]
      end
    end
  end
end
