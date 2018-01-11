require_dependency 'manageiq/graphql/application_controller'

module ManageIQ
  module GraphQL
    class GraphQLController < ApplicationController
      before_action :authenticate!

      attr_reader :current_user

      def execute
        variables = ensure_hash(params[:variables])
        query = params[:query]
        operation_name = params[:operationName]
        context = {
          current_user: current_user
        }
        result = Schema.execute(query, variables: variables, context: context, operation_name: operation_name)
        render json: result
      end

      private

      # Handle form data, JSON body, or a blank value
      def ensure_hash(ambiguous_param)
        case ambiguous_param
        when String
          if ambiguous_param.present?
            ensure_hash(JSON.parse(ambiguous_param))
          else
            {}
          end
        when Hash, ActionController::Parameters
          ambiguous_param
        when nil
          {}
        else
          raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
        end
      end

      def authenticate!
        token = request.headers['HTTP_X_AUTH_TOKEN']
        api_token_mgr = ::Api::UserTokenService.new.token_mgr('api')

        if token && api_token_mgr.token_valid?(token) && userid = api_token_mgr.token_get_info(token, :userid)
          user = User.lookup_by_identity(userid)
          User.current_user = user
          @current_user = user
        else
          render :status => 401, :json => { :data => nil, :errors => [ { 'message' => 'Unauthorized' } ] }
        end
      end
    end
  end
end
