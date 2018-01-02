require 'manageiq/graphql/types/date_time'
require 'manageiq/graphql/types/host'
require 'manageiq/graphql/types/service'
require 'manageiq/graphql/types/tag'
require 'manageiq/graphql/types/user'
require 'manageiq/graphql/types/vm'

module ManageIQ
  module GraphQL
    module Types
      Query = ::GraphQL::ObjectType.define do
        name 'Query'

        field :host, Host, "Look up a host by its ID" do
          argument :id, types.ID

          resolve -> (obj, args, ctx) {
            host = ::Host.find(args[:id])
            ::Rbac.filtered_object(host)
          }
        end

        field :hosts, !types[Host], "List available hosts" do
          argument :tags, types[types.String]

          resolve -> (obj, args, ctx) {
            hosts = if args[:tags]
                      ::Host.find_tagged_with(:all => args[:tags].join(" "), :ns => Classification::DEFAULT_NAMESPACE)
                    else
                      ::Host.all
                    end
            ::Rbac.filtered(hosts)
          }
        end

        field :service, Service, "Look up a service by its ID" do
          argument :id, types.ID

          resolve -> (obj, args, ctx) {
            service = ::Service.find(args[:id])
            ::Rbac.filtered_object(service)
          }
        end

        field :services, !types[Service], "List available services" do
          argument :tags, types[types.String]

          resolve -> (obj, args, ctx) {
            services = if args[:tags]
                         ::Service.find_tagged_with(:all => args[:tags].join(" "), :ns => Classification::DEFAULT_NAMESPACE)
                       else
                         ::Service.all
                       end
            ::Rbac.filtered(services)
          }
        end

        field :tags, !types[Tag], "List available tags" do
          resolve -> (obj, args, ctx) {
            ::Rbac.filtered(::Tag.all)
          }
        end

        field :viewer, User, "The currently logged-in user" do
          resolve -> (obj, args, ctx) {
            ctx[:current_user]
          }
        end

        field :vm, Vm, "Look up a virtual machine by its ID" do
          argument :id, types.ID

          resolve -> (obj, args, ctx) {
            vm = ::Vm.find(args[:id])
            ::Rbac.filtered_object(vm)
          }
        end

        field :vms, !types[Vm], "List available virtual machines" do
          argument :tags, types[types.String]

          resolve -> (obj, args, ctx) {
            vms = if args[:tags]
                    ::Vm.find_tagged_with(:all => args[:tags].join(" "), :ns => Classification::DEFAULT_NAMESPACE)
                  else
                    ::Vm.all
                  end
            ::Rbac.filtered(vms)
          }
        end
      end
    end
  end
end
