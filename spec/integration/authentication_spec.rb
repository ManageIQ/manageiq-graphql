require "manageiq_helper"

RSpec.describe "authentication" do
  describe "basic authentication" do
    as_user(:name => 'Alice', :password => 'alicepassword') do
      it "will authenticate a user with good credentials" do
        post(
          "/graphql",
          :headers => {"Authorization" => encode_basic_auth_credentials(user.userid, user.password) },
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
          :headers => {"Authorization" => encode_basic_auth_credentials(user.userid, "hunter2") },
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
    end
  end

  describe "token authentication" do
    let(:token_service) { Api::UserTokenService.new(:base => {:module => "api", :name => "API"}) }
    let(:token) { token_service.generate_token(user.userid, "api") }

    as_user(:name => 'Alice') do
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
