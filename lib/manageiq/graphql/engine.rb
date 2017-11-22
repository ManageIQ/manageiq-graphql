module ManageIQ
  module GraphQL
    class Engine < ::Rails::Engine
      isolate_namespace ManageIQ::GraphQL
    end
  end
end
