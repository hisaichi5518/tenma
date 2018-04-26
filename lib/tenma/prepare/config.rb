module Tenma
  module Prepare
    class Config
      attr_reader :raw

      def initialize(path)
        @raw = Hashie::Mash.new(YAML.load(File.read(path)))
        validate!
      end

      def github_reponame
        raw.github.owner + "/" + raw.github.repo
      end

      private
      def validate!
        # TODO
      end
    end
  end
end
