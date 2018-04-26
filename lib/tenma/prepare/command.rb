require 'tenma/prepare/context'
require 'tenma/prepare/kpt_issue'
require 'tenma/prepare/release_issue'
require 'tenma/prepare/release_branch'
require 'tenma/prepare/release_pullreqs'

module Tenma
  module Prepare
    class Command
      def initialize(cli)
        @cli = cli
      end

      def execute
        @context = Tenma::Prepare::Context.new.load!(@cli.options)
        if @context.options.create_kpt_issue?
          Tenma::Prepare::KptIssue.new(@context).create
        end

        if @context.options.create_release_issue?
          Tenma::Prepare::ReleaseIssue.new(@context).create
        end

        if @context.options.create_release_branch?
          Tenma::Prepare::ReleaseBranch.new(@context).create
        end

        if @context.options.create_release_pullreqs?
          Tenma::Prepare::ReleasePullreqs.new(@context).create
        end
      end
    end
  end
end
