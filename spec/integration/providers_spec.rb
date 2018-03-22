require "manageiq_helper"

RSpec.describe "Provider queries" do
  describe "'providers' field" do
    as_user do
      let!(:provider) do
        FactoryGirl.create(:ems_vmware, :name => "Alice's Provider")
      end

      it "will return the specified fields of all providers" do
        execute_graphql <<~QUERY
          {
            providers {
              edges {
                node {
                  name
                }
              }
            }
          }
        QUERY

        expect(response.parsed_body).to eq("data" => {"providers" => { "edges" => [{ "node" => {"name" => "Alice's Provider"} }] } })
      end

      it "will return the hosts of all providers" do
        FactoryGirl.create(:host_vmware, :name => "Alice's Host", :ext_management_system => provider)

        execute_graphql <<~QUERY
          {
            providers {
              edges {
                node {
                  hosts {
                    edges {
                      node {
                        name
                      }
                    }
                  }
                }
              }
            }
          }
        QUERY

        expected = {
          "data" => {
            "providers" => {
              "edges" => [
                {
                  "node" => {
                    "hosts" => {
                      "edges" => [
                        {
                          "node" => {
                            "name" => "Alice's Host"
                          }
                        }
                      ]
                    }
                  }
                }
              ]
            }
          }
        }
        expect(response.parsed_body).to eq(expected)
      end

      example "providers can be filtered by tag" do
        FactoryGirl.create(:ems_vmware, :name => "Bob's Provider").tap do |ems|
          ems.tag_add("<3<3<3", :ns => "/managed")
        end

        execute_graphql <<~QUERY
          {
            providers(tags: ["<3<3<3"]) {
              edges {
                node {
                  name
                }
              }
            }
          }
        QUERY

        expect(response.parsed_body).to eq("data" => {"providers" => { "edges" => [{ "node" => {"name" => "Bob's Provider"} }] } })
      end
    end
  end
end
