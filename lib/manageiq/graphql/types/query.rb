require 'manageiq/graphql/types/vm'

module ManageIQ
  module GraphQL
    module Types
      Query = ::GraphQL::ObjectType.define do
        name 'Query'

        field :vms, !types[Types::Vm] do
          resolve -> (obj, args, ctx) {
            ::ManageIQ::Vm.all
          }
        end
      end
    end
  end
end
