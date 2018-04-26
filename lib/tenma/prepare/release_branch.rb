require 'git'
require 'uri'
require 'erb'

module Tenma
  module Prepare
    class ReleaseBranch

      TEMP_DIR = "tenma-build"

      def initialize(context)
        @context = context
      end

      def create
        @workdir = Dir.mktmpdir
        git = Git.clone(repo_url, TEMP_DIR, path: @workdir, depth: 1, branch: base_branch)

        git.branch(release_branch).checkout

        File.write(version_file, @context.options.raw.version)
        git.add(version_file)

        git.commit("version++")

        changelogs = @context.config.raw.release_branch&.changelogs
        changelogs&.each do |changelog|
          file = create_changelog_file(changelog)
          git.add(file)
          git.commit("Add changelog to #{changelog.path}")
        end
        git.push(git.remote("origin"), release_branch)
      end

      def create_changelog_file(changelog)
        FileUtils::mkdir_p(File.join(@workdir, TEMP_DIR, changelog.path))

        file = changelog_file(changelog.path)
        File.open(file, 'w') do |file|
          file.puts changelog(changelog.body)
        end

        return file
      end

      def changelog(note)
        return '' if note.nil?

        ERB.new(note).result(binding)
      end

      private
      def repo_url
        base = URI.parse(@context.config.raw.github.web_url)
        return base.scheme + "://" + @context.options.raw.github_token + ":x-oauth-basic@" + base.host + "/" + @context.config.github_reponame + ".git"
      end

      def base_branch
        if @context.options.hotfix?
          ERB.new(@context.config.raw.release_branch.hotfix.base).result(binding)
        else
          ERB.new(@context.config.raw.release_branch.normal.base).result(binding)
        end
      end

      def version_file
        File.absolute_path(File.join(@workdir, TEMP_DIR, @context.config.raw.release_branch.version_file))
      end

      def changelog_file(path)
        file = parse_version.to_s + '.txt'
        File.absolute_path(File.join(@workdir, TEMP_DIR, path, file))
      end

      def parse_version
        version = @context.options.raw.version
        major = version.split('.')[0].to_i
        minor = version.split('.')[1].to_i
        patch = version.split('.')[2].to_i
        return major * 1000 * 1000 + minor * 1000 + patch
      end

      def release_branch
        if @context.options.hotfix?
          ERB.new(@context.config.raw.release_branch.hotfix.branch).result(binding)
        else
          ERB.new(@context.config.raw.release_branch.normal.branch).result(binding)
        end
      end
    end
  end
end
