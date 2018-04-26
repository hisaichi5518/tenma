require 'tenma/ichiba/options'

module Tenma
  module Ichiba
    class Context

      USER = ENV["USER"] or raise "Can't read ENV[USER]"

      attr_reader :options

      def load!(opts)
        @options = Tenma::Ichiba::Options.new(opts)
        self
      end
    end
  end
end
