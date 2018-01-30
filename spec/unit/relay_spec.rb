RSpec.describe "Relay specification compliance (unit)" do
  describe "Global Object Identification" do
    # https://facebook.github.io/relay/graphql/objectidentification.htm

    context "introspection" do
      let(:query) { '' }
      let(:context) { {} }
      let(:variables) { {} }
      let(:result) do
        ManageIQ::GraphQL::Schema.execute(
          query,
          :context   => context,
          :variables => variables
        )
      end

      describe "Node interface" do
        let(:query) do
          <<~QUERY
            {
              __type(name: "Node") {
                name
                kind
                fields {
                  name
                  type {
                    kind
                    ofType {
                      name
                      kind
                    }
                  }
                }
              }
            }
          QUERY
        end

        it "follows section 2.1 of the global object identification spec" do
          expected = { "__type" => { "name"   => "Node",
                                     "kind"   => "INTERFACE",
                                     "fields" => [{ "name" => "id",
                                                    "type" => { "kind"   => "NON_NULL",
                                                                "ofType" => { "name" => "ID",
                                                                              "kind" => "SCALAR" }}}]}}

          expect(result['data']).to eq(expected)
        end
      end

      describe "Node root field" do
        let(:query) do
          <<~QUERY
            {
              __schema {
                queryType {
                  fields {
                    name
                    type {
                      name
                      kind
                    }
                    args {
                      name
                      type {
                        kind
                        ofType {
                          name
                          kind
                        }
                      }
                    }
                  }
                }
              }
            }
          QUERY
        end

        it "follows section 3.1 of the global object identification spec" do
          expect(result['data']).to match(
            "__schema" =>
            { "queryType" =>
              { "fields" =>
                array_including(
                  "name" => "node",
                  "type" => {"name" => "Node", "kind" => "INTERFACE"},
                  "args" => [{ "name" => "id", "type" => { "kind" => "NON_NULL", "ofType" => { "name" => "ID", "kind" => "SCALAR" } } }]
                )
              }
            }
          )
        end
      end
    end
  end
end
