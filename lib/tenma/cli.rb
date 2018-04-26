require 'thor'
require 'tenma/prepare/command'

module Tenma
  class CLI < ::Thor

    desc "prepare", "Prepare for mobile application releases"
    option "kpt-issue", type: :boolean
    option "release-issue", type: :boolean
    option "release-branch", type: :boolean
    option "release-pullreqs", type: :boolean
    option "config-file", type: :string, default: "tenma/prepare.yml"
    option "github-token", type: :string, default: ENV["TENMA_GITHUB_TOKEN"]
    option "version", type: :string, required: true
    def prepare
      Tenma::Prepare::Command.new(self).execute
    end
  end
end
