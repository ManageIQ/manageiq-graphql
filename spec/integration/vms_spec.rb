require "manageiq_helper"

RSpec.describe "Vm queries" do
  let(:token_service) { Api::UserTokenService.new(:base => {:module => "api", :name => "API"}) }
  let(:token) { token_service.generate_token(user.userid, "api") }

  describe "'vms' field" do
    as_user do
      before do
        FactoryGirl.create(:vm, :name => "Alice's VM")
      end

      it "will return the specified fields of all vms" do
        post(
          "/graphql",
          :headers => {"HTTP_X_AUTH_TOKEN" => token},
          :params  => {:query => "{ vms { edges { node { name } } } }"},
          :as      => :json
        )

        expect(response.parsed_body).to eq("data" => {"vms" => { "edges" => [{ "node" => {"name" => "Alice's VM"} }] } })
      end
    end
  end
end
