RSpec.shared_context "integration test setup" do
  let(:server) { FactoryGirl.create(:miq_server) }
  let(:user) { FactoryGirl.create(:user) }
  let(:token_service) { Api::UserTokenService.new(:base => {:module => "api", :name => "API"}) }
  let(:token) { token_service.generate_token(user.userid, "api") }

  before do
    Tenant.create!(:use_config_for_attributes => false)
    allow(MiqServer).to receive(:my_guid).and_return(server.guid)
    MiqServer.my_server_clear_cache
  end
end
