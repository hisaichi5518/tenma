require "erb"

module Tenma
  module Prepare
    class ReleaseIssue
      def initialize(context)
        @context = context
      end

      def create
        @context.client.create_issue(
          @context.config.github_reponame,
          formatted_title,
          formatted_body,
          {
            labels: @context.config.raw.release_issue.labels,
            assignee: @context.release_manager.login,
            milestone: @context.milestone.number,
          }
        )
      end

      private
      def formatted_title
        ERB.new(@context.config.raw.release_issue.title).result(binding)
      end

      def formatted_body
        ERB.new(@context.config.raw.release_issue.body).result(binding)
      end
    end
  end
end
