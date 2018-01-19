module ManageIQ
  module GraphQL
    class ApplicationController < ActionController::API
      include ActionController::HttpAuthentication::Basic::ControllerMethods

      before_action :authenticate!

      attr_reader :current_user

      private

      def authenticate!
        return if try_authenticate_with_http_basic || try_authenticate_with_http_token
        headers["WWW-Authenticate"] = 'Basic realm="Application"'
        render :status => 401, :json => { :data => nil, :errors => [{ 'message' => 'Unauthorized' }] }
      end

      def try_authenticate_with_http_basic
        return unless request.headers["HTTP_AUTHORIZATION"]
        @current_user = authenticate_with_http_basic do |username, password|
          User.authenticate(
            username,
            password,
            request,
            :require_user => true,
            :timeout      => ::Settings.graphql_api.authentication_timeout.to_i_with_method
          )
        end
        User.current_user = @current_user
        true
      rescue MiqException::MiqEVMLoginError
        nil
      end

      def try_authenticate_with_http_token
        return unless request.headers["HTTP_X_AUTH_TOKEN"]
        token = request.headers['HTTP_X_AUTH_TOKEN']
        api_token_mgr = ::Api::UserTokenService.new.token_mgr('api')

        if token && api_token_mgr.token_valid?(token) && userid = api_token_mgr.token_get_info(token, :userid)
          user = User.lookup_by_identity(userid)
          User.current_user = user
          @current_user = user
        end
        true
      end
    end
  end
end
