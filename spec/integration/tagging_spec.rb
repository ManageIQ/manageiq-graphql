require "manageiq_helper"

RSpec.describe "Tagging" do
  describe "addTags mutation" do
    let(:taggable) { FactoryGirl.create(:vm_vmware, :name => "Sooper Cool VM") }

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
          execute_graphql(mutation)
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

  describe "removeTags mutation" do
    let(:tags) do
      tags = []
      %w(tag1 tag2 tag3).each do |name|
        tags << Tag.create(:name => "/user/#{name}")
      end
      tags
    end

    let(:taggable) do
      FactoryGirl.create(:vm_vmware, :name => "Sooper Cool VM", :tags => tags)
    end

    let(:mutation) do
      <<~MUTATION
        mutation {
          removeTags(input:{taggableId:"#{relay_id_from(taggable)}", tagNames: ["tag1", "tag3"]}) {
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
      it "will remove tags from the taggable" do
        expect {
          execute_graphql(mutation)
        }.to change { taggable.tags.reload.size }.from(3).to(1)

        expected = {
          "data" => {
            "removeTags" => {
              "taggable" => {
                "name" => "Sooper Cool VM",
                "tags" => match_array([{ "name" => "/user/tag2" }])
              }
            }
          }
        }

        expect(response.parsed_body).to match(expected)
      end
    end
  end
end
