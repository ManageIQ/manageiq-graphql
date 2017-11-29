require 'manageiq/graphql/types/vm'

module ManageIQ
  module GraphQL
    module Types
      Query = ::GraphQL::ObjectType.define do
        name 'Query'

        field :vms, !types[Types::Vm], "List available virtual machines" do
          resolve -> (obj, args, ctx) {
            ::Vm.all
          }
        end
      end
    end
  end
end
