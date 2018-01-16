Pathname.glob(Pathname(__FILE__).dirname.join("types/**/*.rb")).each do |file|
  require_dependency file
end

module ManageIQ
  module GraphQL
    Schema = ::GraphQL::Schema.define do
      use ::GraphQL::Batch

      raise_definition_error true
      enable_preloading

      query Types::Query
      mutation Types::Mutation

      resolve_type ->(type, obj, ctx) {
        # This is horrible. It's horrible because this is a PoC
        # and it just needs to prove that one can resolve our AR models to
        # GraphQL types. dealwithit.gif
        if /Vm/ =~ obj.class.name
          Types::Vm
        elsif /Service/ =~ obj.class.name
          Types::Service
        end
      }
    end
  end
end
