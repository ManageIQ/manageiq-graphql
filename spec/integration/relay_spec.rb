require "manageiq_helper"

RSpec.describe "Relay specification compliance (integration)" do
  describe "Global Object Identification" do
    context "given an object with an ID" do
      as_user do
        before do
          FactoryGirl.create(:vm, :name => "Sooper Special VM")

          execute_graphql <<~QUERY
            {
              vms {
                edges {
                  node {
                    id
                    name
                  }
                }
              }
            }
          QUERY
        end

        example "the same object can be requeried by its node ID" do
          vm_id = response.parsed_body.dig('data', 'vms', 'edges').first.dig('node', 'id')

          execute_graphql <<~QUERY
            {
              node(id: "#{vm_id}") {
                id
                ... on Vm {
                  name
                }
              }
            }
          QUERY

          expected = {
            "data" => {
              "node" => {
                "id"   => vm_id,
                "name" => "Sooper Special VM"
              }
            }
          }

          expect(response.parsed_body).to eq(expected)
        end
      end
    end
  end
end
