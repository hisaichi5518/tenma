module Tenma
  module Ichiba
    class Validator
      attr_reader :context
      def initialize(context)
        @context = context
      end

      def validate!
        if !command?("gcloud")
          raise ValidationException, "required gcloud command"
        end

        if !File.exist?(context.options.raw.node_yaml)
          raise ValidationException, "Can't find #{context.options.raw.node_yaml}"
        end

        if context.options.provision_instance? && (ENV["USER"].nil? || ENV["USER"].empty?)
          raise ValidationException, "ENV[USER] is nil or empty..."
        end
      end

      def command?(command)
        system "which #{command} > /dev/null 2>&1"
      end

      class ValidationException < Exception
      end
    end
  end
end
