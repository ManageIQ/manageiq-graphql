module ManageIQ
  module GraphQL
    module CustomMatchers
      extend RSpec::Matchers::DSL

      matcher :resolve do |object, args = nil, context = nil|
        match do |field|
          field.resolve(object, args, context) == @expected
        end

        chain :to do |expected|
          @expected = expected
        end
      end
    end
  end
end
