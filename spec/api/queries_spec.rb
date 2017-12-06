RSpec.describe "Queries" do
  it "can retrieve the list of queries" do
    query_string = <<-GRAPHQL
query GetVms {
  vms {
    name
  }
}
GRAPHQL
    query = GraphQL::Query.new(ManageIQ::GraphQL::Schema, query_string)
    allow(QueriesRepository).to receive(:all).and_return([query])

    get("/graphql/queries")

    expected = {
      "data" => [
        {
          "operationName" => "GetVms",
          "query" => query_string
        }
      ]
    }
    expect(response.parsed_body).to eq(expected)
  end
end
