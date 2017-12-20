module ManageIQ
  module GraphQL
    class QueueService
      def self.enqueue(*args)
        new.enqueue(*args)
      end

      def initialize
      end

      def enqueue(object, description, options)
        task_options = {
          :action => description,
          :userid => User.current_user.userid
        }

        queue_options = {
          :class_name  => options[:class_name] || object.class.name,
          :method_name => options[:method_name],
          :instance_id => object.id,
          :args        => options[:args] || [],
          :role        => options[:role] || nil,
        }

        queue_options.merge!(options[:user]) if options.key?(:user)
        queue_options[:zone] = object.my_zone if %w(ems_operations smartstate).include?(options[:role])

        MiqTask.generic_action_with_callback(task_options, queue_options)
      end
    end
  end
end
