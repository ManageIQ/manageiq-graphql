require_dependency 'manageiq/graphql/application_controller'

module ManageIQ
  module GraphQL
    class GraphQLController < ApplicationController
      include ActionController::HttpAuthentication::Basic::ControllerMethods

      before_filter :authenticate

      def execute
        variables = ensure_hash(params[:variables])
        query = params[:query]
        operation_name = params[:operationName]
        context = {
          # Query context goes here, for example:
          # current_user: current_user,
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

      def authenticate
        if ActionController::HttpAuthentication::Basic.has_basic_credentials?(request)
          @current_user = authenticate_with_http_basic do |username, password|
            User.authenticate(
              username,
              password,
              request,
              :require_user => true,
              :timeout      => ::Settings.api.authentication_timeout.to_i_with_method
            )
          end
        else
          head :unauthorized
        end
      rescue MiqException::MiqEVMLoginError
        head :unauthorized
      end
    end
  end
end
