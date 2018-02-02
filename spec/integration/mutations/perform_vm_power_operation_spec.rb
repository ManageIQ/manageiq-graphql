require "manageiq_helper"

RSpec.describe 'performVmPowerOperation' do
  let(:token_service) { Api::UserTokenService.new(:base => {:module => "api", :name => "API"}) }
  let(:token) { token_service.generate_token(user.userid, "api") }
  let(:vm) { FactoryGirl.create(:vm) }

  as_user do
    let(:query) do
      <<~QUERY
        mutation {
          performVmPowerOperation(input:{vmId: "#{relay_id_from(vm)}", operation: START}) {
            success
            message
            taskId
          }
        }
      QUERY
    end

    it "responds with a successful payload" do
      expect(ManageIQ::GraphQL::QueueService).to receive(:enqueue).and_return(1337)

      post(
        "/graphql",
        :headers => { "HTTP_X_AUTH_TOKEN" => token },
        :params  => { :query => query },
        :as      => :json
      )

      expected = {
        "success" => true,
        "message" => a_string_including("Performing start operation on VM id: #{relay_id_from(vm)}"),
        "taskId"  => "1337"
      }

      expect(response.parsed_body['data']['performVmPowerOperation']).to match(expected)
    end
  end
end
