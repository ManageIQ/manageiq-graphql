import GraphQLExplorer from "../graphql-explorer";

const { componentRegistry } = window.ManageIQ.react;

componentRegistry.register({
  name: "graphql_explorer",
  type: GraphQLExplorer
});
