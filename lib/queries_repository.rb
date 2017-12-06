class QueriesRepository
  def self.all
    Dir.glob(ManageIQ::GraphQL::Engine.root.join("app", "queries", "*.graphql")).map do |file|
      GraphQL::Query.new(ManageIQ::GraphQL::Schema, File.read(file))
    end
  end
end
