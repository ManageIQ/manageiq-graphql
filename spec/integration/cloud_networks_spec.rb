require "manageiq_helper"

RSpec.describe "Cloud Network queries" do
  describe "'cloudNetworks' field" do
    as_user do
      let!(:network) do
        FactoryGirl.create(:cloud_network, :name => "Test Network 1")
      end

      it "will return the specified fields of all cloud networks" do
        execute_graphql <<~QUERY
          {
            cloudNetworks {
              edges {
                node {
                  name
                }
              }
            }
          }
        QUERY

        expect(response.parsed_body).to eq("data" => {"cloudNetworks" => { "edges" => [{ "node" => {"name" => "Test Network 1"} }] } })
      end

      example "networks can be filtered by tag" do
        FactoryGirl.create(:cloud_network, :name => "Test Network 2").tap do |ems|
          ems.tag_add("<3<3<3", :ns => "/managed")
        end

        execute_graphql <<~QUERY
          {
            cloudNetworks(tags: ["<3<3<3"]) {
              edges {
                node {
                  name
                }
              }
            }
          }
        QUERY

        expect(response.parsed_body).to eq("data" => {"cloudNetworks" => { "edges" => [{ "node" => {"name" => "Test Network 2"} }] } })
      end
    end
  end
end
