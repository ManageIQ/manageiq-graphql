module ManageIQ
  module GraphQL
    module Types
      Query = ::GraphQL::ObjectType.define do
        name 'Query'
        description 'The root type for a query operation; a read-only fetch.'

        field :node,  ::GraphQL::Relay::Node.field
        field :nodes, ::GraphQL::Relay::Node.plural_field

        field :hosts, !types[Host], "List available hosts" do
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

        field :services, !types[Service], "List available services" do
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

        field :tags, !types[Tag], "List available tags" do
          resolve ->(_obj, _args, _ctx) {
            ::Rbac.filtered(::Tag.all)
          }
        end

        field :viewer, User, "The currently logged-in user" do
          resolve ->(_obj, _args, ctx) {
            ctx[:current_user]
          }
        end

        field :vms, !types[Vm], "List available virtual machines" do
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
