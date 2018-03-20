require "manageiq_helper"

RSpec.describe "Provider queries" do
  describe "'providers' field" do
    as_user do
      before do
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
    end
  end
end
