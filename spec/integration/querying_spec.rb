require "manageiq_helper"

RSpec.describe "Querying" do
  as_user(:name => "Alice", :userid => "Alice", :password => "alicepassword") do
    example "queries can be sent in the query string via the GET method" do
      get(
        "/graphql",
        :headers => {"Authorization" => encode_basic_auth_credentials(user.userid, user.password)},
        :params  => {:query => "{ viewer { name } }"}
      )

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to eq("data" => {"viewer" => {"name" => "Alice"}})
    end
  end
end
