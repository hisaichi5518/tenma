require "hashie/mash"

module Tenma
  module Prepare
    class Options

      attr_reader :raw
      def initialize(opts)
        @raw = Hashie::Mash.new(opts.map { |k, v| [k.gsub(/-/, "_"), v]  }.to_h)
      end

      def create_kpt_issue?
        return !!raw.kpt_issue
      end

      def create_release_issue?
        return !!raw.release_issue
      end

      def create_release_branch?
        return !!raw.release_branch
      end

      def create_release_pullreqs?
        return !!raw.release_pullreqs
      end

      def create_release_note?
        return !!raw.release_note
      end

      def hotfix?
        raw.version.split(".")[2] != "0"
      end

    end
  end
end
