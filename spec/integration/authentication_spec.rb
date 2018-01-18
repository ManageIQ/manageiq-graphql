require "manageiq_helper"

RSpec.describe "authentication" do
  let(:server) { FactoryGirl.create(:miq_server) }
  let(:user) { FactoryGirl.create(:user) }
  let(:token_service) { Api::UserTokenService.new(:base => {:module => "api", :name => "API"}) }
  let(:token) { token_service.generate_token(user.userid, "api") }

  before do
    Tenant.create!(:use_config_for_attributes => false)
    allow(MiqServer).to receive(:my_guid).and_return(server.guid)
    MiqServer.my_server_clear_cache
  end

  describe "basic authentication" do
    let(:user) { FactoryGirl.create(:user, :name => "Alice", :userid => "Alice", :password => "alicepassword") }

    it "will authenticate a user with good credentials" do
      post(
        "/graphql",
        :headers => {"Authorization" => encode_credentials(user.userid, user.password) },
        :params  => {:query => "{ viewer { name } }"},
        :as      => :json
      )

      expected = {
        "data" => {
          "viewer" => {
            "name" => "Alice"
          }
        }
      }
      expect(response.parsed_body).to eq(expected)
    end

    it "responds with an error message and a challenge for a user with bad credentials" do
      post(
        "/graphql",
        :headers => {"Authorization" => encode_credentials(user.userid, "hunter2") },
        :params  => {:query => "{ viewer { name } }"},
        :as      => :json
      )

      expected = {
        "data"   => nil,
        "errors" => [
          {"message" => "Unauthorized"}
        ]
      }
      expect(response.parsed_body).to eq(expected)
      expect(response.headers["WWW-Authenticate"]).to eq('Basic realm="Application"')
    end

    def encode_credentials(user, password)
      ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
    end
  end

  describe "token authentication" do
    let(:user) { FactoryGirl.create(:user, :name => "Alice") }

    it "will authenticate a user with a token" do
      post(
        "/graphql",
        :headers => {"HTTP_X_AUTH_TOKEN" => token},
        :params  => {:query => "{ viewer { name } }"},
        :as      => :json
      )

      expected = {
        "data" => {
          "viewer" => {
            "name" => "Alice"
          }
        }
      }
      expect(response.parsed_body).to eq(expected)
    end
  end

  describe "no unauthentication" do
    it "responds with an error message and a challenge" do
      post(
        "/graphql",
        :params => {:query => "{ viewer { name } }"},
        :as     => :json
      )

      expected = {
        "data"   => nil,
        "errors" => [
          {"message" => "Unauthorized"}
        ]
      }
      expect(response.parsed_body).to eq(expected)
      expect(response.headers["WWW-Authenticate"]).to eq('Basic realm="Application"')
    end
  end
end
