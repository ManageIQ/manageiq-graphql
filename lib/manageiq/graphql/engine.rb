require 'manageiq/graphql/rest_api_proxy'

module ManageIQ
  module GraphQL
    class Engine < ::Rails::Engine
      ActiveSupport::Inflector.inflections(:en) do |inflect|
        inflect.acronym("ManageIQ")
        inflect.acronym("GraphQL")
        inflect.acronym("GraphiQL")
      end

      isolate_namespace ManageIQ::GraphQL

      # NOTE:  If you are going to make changes to autoload_paths, please make
      # sure they are all strings.  Rails will push these paths into the
      # $LOAD_PATH.
      #
      # More info can be found in the ruby-lang bug:
      #
      #   https://bugs.ruby-lang.org/issues/14372
      #
      config.autoload_paths << root.join('lib').to_s

      initializer "graphql.add_rest_proxy" do |app|
        app.middleware.use(ManageIQ::GraphQL::RESTAPIProxy)
      end

      initializer "graphql.assets" do |app|
        app.config.assets.paths << root.join("node_modules").to_s
      end

      def self.plugin_name
        _('GraphQL')
      end

      def vmdb_plugin?
        true
      end
    end
  end
end
