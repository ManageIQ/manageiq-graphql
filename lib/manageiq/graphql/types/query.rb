module ManageIQ
  module GraphQL
    module Types
      Query = ::GraphQL::ObjectType.define do
        name 'Query'
        description 'The root type for a query operation; a read-only fetch.'

        field :node,  ::GraphQL::Relay::Node.field
        field :nodes, ::GraphQL::Relay::Node.plural_field

        connection :hosts, !Host.connection_type, "List available hosts" do
          argument :tags, types[types.String]

          resolve ->(_obj, args, _ctx) {
            hosts = if args[:tags]
                      ::Host.find_tagged_with(:all => args[:tags].join(" "), :ns => Classification::DEFAULT_NAMESPACE)
                    else
                      ::Host.all
                    end
            ::Rbac.filtered(hosts)
          }
        end

        connection :providers, !Provider.connection_type, "List available providers" do
          argument :tags, types[types.String]

          resolve ->(_obj, args, _ctx) {
            providers = if args[:tags]
                          ::ExtManagementSystem.find_tagged_with(:all => args[:tags].join(" "), :ns => Classification::DEFAULT_NAMESPACE)
                        else
                          ::ExtManagementSystem.all
                        end
            ::Rbac.filtered(providers)
          }
        end

        connection :services, !Service.connection_type, "List available services" do
          argument :tags, types[types.String]

          resolve ->(_obj, args, _ctx) {
            services = if args[:tags]
                         ::Service.find_tagged_with(:all => args[:tags].join(" "), :ns => Classification::DEFAULT_NAMESPACE)
                       else
                         ::Service.all
                       end
            ::Rbac.filtered(services)
          }
        end

        connection :tags, !Tag.connection_type, "List available tags" do
          resolve ->(_obj, _args, _ctx) {
            ::Rbac.filtered(::Tag.all)
          }
        end

        field :viewer, User, "The currently logged-in user" do
          resolve ->(_obj, _args, ctx) {
            ctx[:current_user]
          }
        end

        connection :vms, !Vm.connection_type, "List available virtual machines" do
          argument :tags, types[types.String]

          resolve ->(_obj, args, _ctx) {
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
