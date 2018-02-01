require "manageiq_helper"

RSpec.describe "Tagging" do
  let(:token_service) { Api::UserTokenService.new(:base => {:module => "api", :name => "API"}) }
  let(:token) { token_service.generate_token(user.userid, "api") }

  let(:taggable) { FactoryGirl.create(:vm, :name => "Sooper Cool VM") }

  describe "addTags mutation" do
    let(:mutation) do
      <<~MUTATION
        mutation {
          addTags(input:{taggableId:"#{relay_id_from(taggable)}", tagNames: ["AddedTag1", "AddedTag2"]}) {
            taggable {
              ... on Vm {
                name
              }
              tags {
                name
              }
            }
          }
        }
      MUTATION
    end

    as_user do
      it "will add the tags to the taggable" do
        expect {
          post(
            "/graphql",
            :headers => {"HTTP_X_AUTH_TOKEN" => token},
            :params  => {:query => mutation},
            :as      => :json
          )
        }.to change { taggable.tags.reload.size }.from(0).to(2)

        expected = {
          "data" => {
            "addTags" => {
              "taggable" => {
                "name" => "Sooper Cool VM",
                "tags" => match_array([{ "name" => "/user/AddedTag1" }, { "name" => "/user/AddedTag2" }])
              }
            }
          }
        }

        expect(response.parsed_body).to match(expected)
      end
    end
  end
end
