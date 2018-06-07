require "manageiq_helper"

RSpec.describe "Network queries" do
  describe "'networks' field" do
    as_user do
      let!(:network) do
        FactoryGirl.create(:cloud_network, :name => "Test Network 1")
      end

      it "will return the specified fields of all networks" do
        execute_graphql <<~QUERY
          {
            networks {
              edges {
                node {
                  name
                }
              }
            }
          }
        QUERY

        expect(response.parsed_body).to eq("data" => {"networks" => { "edges" => [{ "node" => {"name" => "Test Network 1"} }] } })
      end

      example "networks can be filtered by tag" do
        FactoryGirl.create(:cloud_network, :name => "Test Network 2").tap do |ems|
          ems.tag_add("<3<3<3", :ns => "/managed")
        end

        execute_graphql <<~QUERY
          {
            networks(tags: ["<3<3<3"]) {
              edges {
                node {
                  name
                }
              }
            }
          }
        QUERY

        expect(response.parsed_body).to eq("data" => {"networks" => { "edges" => [{ "node" => {"name" => "Test Network 2"} }] } })
      end
    end
  end
end
