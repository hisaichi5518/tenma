module Tenma
  module Prepare
    class ReleasePullreqs

      def initialize(context)
        @context = context
      end

      def create
        @context.config.raw.release_pullreq.bases.each do |base_branch|
          pullreq =  @context.client.create_pull_request(
            @context.config.github_reponame,
            base_branch,
            release_branch,
            formatted_title(base_branch),
            formatted_body(base_branch),
          )

          @context.client.update_issue(
            @context.config.github_reponame,
            pullreq.number,
            labels: @context.config.raw.release_pullreq.labels,
            assignee: @context.release_manager.login,
            milestone: @context.milestone.number,
          )
        end
      end

      private
      def release_branch
        if @context.options.hotfix?
          ERB.new(@context.config.raw.release_branch.hotfix.branch).result(binding)
        else
          ERB.new(@context.config.raw.release_branch.normal.branch).result(binding)
        end
      end

      def formatted_title(base_branch)
        ERB.new(@context.config.raw.release_pullreq.title).result(binding)
      end

      def formatted_body(base_branch)
        ERB.new(@context.config.raw.release_pullreq.body).result(binding)
      end

    end
  end
end
