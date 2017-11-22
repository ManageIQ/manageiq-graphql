require 'manageiq/graphql/types/vm'

module ManageIQ::GraphQL::Types
  Query = ::GraphQL::ObjectType.define do
    name 'Query'

    field :vms, !types[Types::Vm] do
      resolve -> (obj, args, ctx) {
        require 'pry'
        binding.pry
        ::ManageIQ::Vm.all
      }
    end
  end
end
