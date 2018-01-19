module ManageIQ
  module GraphQL
    ##
    # A simple Rack Middlware for forwarding specific calls to the REST API
    # This is intended to allow this API to use the REST API as a temporary
    # crutch for things such as token authentication.
    class RESTAPIProxy
      PROXY_PATHS = [
        'auth'
      ].freeze

      def initialize(app)
        @app = app
      end

      def call(env)
        env['REQUEST_PATH'].gsub!("graphql", "api") if proxy?(env)
        @app.call(env)
      end

      private

      def proxy?(env)
        # TODO: Incredibly naive, should take GraphQL engine's mount point in to account and not hardcode
        !!PROXY_PATHS.detect { |path| /\/graphql\/#{path}\z/ =~ env['REQUEST_PATH'] }
      end
    end
  end
end
