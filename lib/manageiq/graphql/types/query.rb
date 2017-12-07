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
          argument :tags, types[types.String]

          resolve -> (obj, args, ctx) {
            if args[:tags]
              ::Service.find_tagged_with(:all => args[:tags].join(" "), :ns => Classification::DEFAULT_NAMESPACE)
            else
              ::Service.all
            end
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
          argument :tags, types[types.String]

          resolve -> (obj, args, ctx) {
            if args[:tags]
              ::Vm.find_tagged_with(:all => args[:tags].join(" "), :ns => Classification::DEFAULT_NAMESPACE)
            else
              ::Vm.all
            end
          }
        end
      end
    end
  end
end
