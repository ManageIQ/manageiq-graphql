require "manageiq_helper"

RSpec.describe "GraphQL endpoint" do
  describe "#endpoint" do
    it "returns /graphql" do
      expect(endpoint_path).to eq("/graphql/")
    end
  end
end
