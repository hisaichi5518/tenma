require 'tenma/prepare/options'
require 'tenma/prepare/config'
require 'octokit'

module Tenma
  module Prepare
    class Context
      attr_reader :options, :config, :client, :milestone, :release_manager

      def load!(opts)
        @options = Tenma::Prepare::Options.new(opts)
        @config = Tenma::Prepare::Config.new(options.raw.config_file)
        @client = load_github_client
        @milestone = load_milestone!
        @release_manager = load_release_manager!

        self
      end

      private
      def load_github_client
        Octokit.configure do |c|
          c.api_endpoint = config.raw.github.api_url
        end
        Octokit::Client.new(access_token: options.raw.github_token)
      end

      def load_milestone!
        milestones = client.milestones(config.github_reponame, {state: "open"}).select do |milestone|
          milestone[:title].include? options.raw.version
        end
        milestones.first or raise "Can't find a milestone."
      end

      def load_release_manager!
        client.user or raise "Can't find release manager."
      end
    end
  end
end
