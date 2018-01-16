require "manageiq_helper"

RSpec.describe "Vm queries" do
  let(:server) { FactoryGirl.create(:miq_server) }
  let(:user) { FactoryGirl.create(:user) }
  let(:token_service) { Api::UserTokenService.new(:base => {:module => "api", :name => "API"}) }
  let(:token) { token_service.generate_token(user.userid, "api") }

  before do
    Tenant.create!(:use_config_for_attributes => false)
    allow(MiqServer).to receive(:my_guid).and_return(server.guid)
    MiqServer.my_server_clear_cache
  end

  describe "'vms' field" do
    it "will return the specified fields of all vms" do
      FactoryGirl.create(:vm, :name => "Alice's VM")

      post(
        "/graphql",
        :headers => {"HTTP_X_AUTH_TOKEN" => token},
        :params  => {:query => "{ vms { name } }"},
        :as      => :json

      )

      expect(response.parsed_body).to eq("data" => {"vms" => [{"name" => "Alice's VM"}]})
    end
  end
end
