require 'thor'
require 'tenma/prepare/command'
require 'tenma/ichiba/command'

module Tenma
  class CLI < ::Thor

    desc "prepare", "Prepare for mobile application releases"
    option "kpt-issue", type: :boolean
    option "release-issue", type: :boolean
    option "release-branch", type: :boolean
    option "release-pullreqs", type: :boolean
    option "release-note", type: :boolean
    option "config-file", type: :string, default: File.expand_path("tenma/prepare.yml")
    option "github-token", type: :string, default: ENV["TENMA_GITHUB_TOKEN"]
    option "version", type: :string, required: true
    def prepare
      Tenma::Prepare::Command.new(self).execute
    end

    desc "ichiba", "instance operation command for Android's remote build"
    option "create-instance", type: :boolean
    option "provision-instance", type: :boolean
    option "delete-instance", type: :boolean
    option "restart-instance", type: :boolean
    option "instance-name", type: :string, default: "remote-build", required: true
    option "instance-zone", type: :string, default: "asia-northeast1-c", required: true
    option "instance-project", type: :string, default: ENV["TENMA_ICHIBA_INSTANCE_PROJECT"], required: true
    option "instance-machine-type", type: :string, default: "n1-highcpu-16", required: true
    option "instance-disk-size", type: :numeric, default: 20, required: true
    option "ssh-key-file", type: :string, default: File.expand_path("~/.ssh/id_rsa"), required: true
    option "node-json", type: :string, default: File.expand_path("tenma/ichiba.json"), required: true
    def ichiba
      Tenma::Ichiba::Command.new(self).execute
    end
  end
end
