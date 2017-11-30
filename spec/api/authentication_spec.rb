RSpec.describe "Authentication" do
  describe "basic authentication" do
    it "authenticates a user with good credentials" do
      user = User.create!(:name => "Alice", :userid => "Alice", :password => "letmein")

      post(
        "http://example.com/graphql",
        :headers => {
          "HTTP_AUTHORIZATION" => encode_credentials(user.userid, user.password)
        },
        :params => {:query => "{ vms { name } }"},
        :as => :json
      )

      expect(response).to have_http_status(:ok)
    end

    it "rejects a user with bad credentials" do
      user = User.create!(:name => "Alice", :userid => "Alice", :password => "letmein")

      post(
        "http://example.com/graphql",
        :headers => {
          "HTTP_AUTHORIZATION" => encode_credentials(user.userid, "keepmeout")
        },
        :params => {:query => "{ vms { name } }"},
        :as => :json
      )

      expect(response).to have_http_status(:unauthorized)
    end

    def encode_credentials(user, password)
      ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
    end
  end

  it "rejects a user with no authentication" do
    post(
      "http://example.com/graphql",
      :params => {:query => "{ vms { name } }"},
      :as => :json
    )

    expect(response).to have_http_status(:unauthorized)
  end
end
