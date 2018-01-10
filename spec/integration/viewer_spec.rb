require "rails_helper"

RSpec.describe "viewer" do
  context "when authenticated" do
    let(:user) { FactoryGirl.create(:user, :name => "Alice") }

    it "will respond with information about the authenticated user" do
      post(
        "/graphql",
        :headers => {"HTTP_X_AUTH_TOKEN" => token},
        :params => {:query => "{ viewer { name } }"},
        :as => :json
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
