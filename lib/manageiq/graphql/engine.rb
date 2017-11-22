module ManageIQ
  module GraphQL
    class Engine < ::Rails::Engine
      isolate_namespace ManageIQ::GraphQL

      ActiveSupport::Inflector.inflections(:en) do |inflect|
        inflect.acronym("ManageIQ")
        inflect.acronym("GraphQL")
        inflect.acronym("GraphiQL")
      end
    end
  end
end
