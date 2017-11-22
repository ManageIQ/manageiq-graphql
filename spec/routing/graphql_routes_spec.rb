RSpec.describe "GraphQL endpoint" do
  describe "#graphql_endpoint" do
    it "returns /graphql" do
      expect(graphql_endpoint_path).to eq("/graphql")
    end
  end
end
