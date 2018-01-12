require "active_support/time"
Time.zone ||= "UTC"

RSpec.describe ManageIQ::GraphQL::Types::DateTime do
  let(:context) { {} }

  example "coercing output" do
    time = Time.utc(2018, 1, 1, 0, 0, 0)

    actual = described_class.coerce_result(time, context)

    expect(actual).to eq("2018-01-01T00:00:00Z")
  end

  example "coercing input" do
    time = "2018-01-01T00:00:00Z"

    actual = described_class.coerce_input(time, context)

    expect(actual).to eq(Time.utc(2018, 1, 1, 0, 0, 0))
  end
end
