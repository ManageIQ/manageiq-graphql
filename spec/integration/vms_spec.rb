require "manageiq_helper"

RSpec.describe "Vm queries" do
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
