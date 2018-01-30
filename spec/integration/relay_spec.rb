require "manageiq_helper"

RSpec.describe "Relay specification compliance (integration)" do
  let(:token_service) { Api::UserTokenService.new(:base => {:module => "api", :name => "API"}) }
  let(:token) { token_service.generate_token(user.userid, "api") }

  describe "Global Object Identification" do
    context "given an object with an ID" do
      as_user do
        before do
          FactoryGirl.create(:vm, :name => "Sooper Special VM")

          post(
            "/graphql",
            :headers => { "HTTP_X_AUTH_TOKEN" => token },
            :params  => { :query => "{ vms { id name } }" },
            :as      => :json
          )
        end

        example "the same object can be requeried by its node ID" do
          vm_id = response.parsed_body['data']['vms'].first['id']

          query = <<~QUERY
            {
              node(id: "#{vm_id}") {
                id
                ... on Vm {
                  name
                }
              }
            }
          QUERY

          post(
            "/graphql",
            :headers => { "HTTP_X_AUTH_TOKEN" => token },
            :params  => { :query => query },
            :as      => :json
          )

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
