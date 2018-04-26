require 'tenma/ichiba/context'
require 'tenma/ichiba/validator'
require 'tenma/ichiba/instance'

module Tenma
  module Ichiba
    class Command
      def initialize(cli)
        @cli = cli
      end

      def execute
        @context = Tenma::Ichiba::Context.new.load!(@cli.options)

        Tenma::Ichiba::Validator.new(@context).validate!

        if @context.options.create_instance?
          Tenma::Ichiba::Instance.new(@context).create
        end

        if @context.options.provision_instance?
          Tenma::Ichiba::Instance.new(@context).provision
        end

        if @context.options.restart_instance?
          Tenma::Ichiba::Instance.new(@context).restart
        end

        if @context.options.delete_instance?
          Tenma::Ichiba::Instance.new(@context).delete
        end
      end
    end
  end
end
