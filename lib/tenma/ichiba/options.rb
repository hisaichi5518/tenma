require "hashie/mash"

module Tenma
  module Ichiba
    class Options

      attr_reader :raw
      def initialize(opts)
        @raw = Hashie::Mash.new(opts.map { |k, v| [k.gsub(/-/, "_"), v]  }.to_h)
      end

      def create_instance?
        return !!raw.create_instance
      end

      def delete_instance?
        return !!raw.delete_instance
      end

      def delete_all_instances?
        return !!raw.delete_all_instances
      end

      def provision_instance?
        return !!raw.provision_instance
      end

      def restart_instance?
        return !!raw.restart_instance
      end

    end
  end
end
