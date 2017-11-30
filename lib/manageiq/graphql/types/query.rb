require 'manageiq/graphql/types/service'
require 'manageiq/graphql/types/tag'
require 'manageiq/graphql/types/vm'

module ManageIQ
  module GraphQL
    module Types
      Query = ::GraphQL::ObjectType.define do
        name 'Query'

        field :service, Service, "Look up a service by its ID" do
          argument :id, types.ID

          resolve -> (obj, args, ctx) {
            ::Service.find(args[:id])
          }
        end

        field :services, !types[Service], "List available services" do
          resolve -> (obj, args, ctx) {
            ::Service.all
          }
        end

        field :tags, !types[Tag], "List available tags" do
          resolve -> (obj, args, ctx) {
            ::Tag.all
          }
        end

        field :vm, Vm, "Look up a virtual machine by its ID" do
          argument :id, types.ID

          resolve -> (obj, args, ctx) {
            ::Vm.find(args[:id])
          }
        end

        field :vms, !types[Vm], "List available virtual machines" do
          resolve -> (obj, args, ctx) {
            ::Vm.all
          }
        end
      end
    end
  end
end
