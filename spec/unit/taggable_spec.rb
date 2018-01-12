RSpec.describe ManageIQ::GraphQL::Types::Taggable do
  include ManageIQ::GraphQL::CustomMatchers

  describe "the tags field" do
    let(:tags_field) { described_class.fields["tags"] }
    let(:tag) { instance_double("::Tag") }
    let(:object) { instance_double("::Vm", :tags => [tag]) }

    it "resolves the tags for a given object" do
      expect(tags_field).to resolve(object).to([tag])
    end
  end
end
