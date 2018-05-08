require 'itamae/runner'

module Tenma
  module Ichiba
    class Instance

      attr_reader :context, :name, :type, :zone, :project, :disk_size

      include Tenma::Runnable

      def initialize(context)
        @context = context
        @name = @context.options.raw.instance_name
        @type = @context.options.raw.instance_machine_type
        @zone = @context.options.raw.instance_zone
        @project = @context.options.raw.instance_project
        @disk_size = @context.options.raw.instance_disk_size
      end

      def create
        puts "Create instance..."
        puts run "gcloud compute instances create #{name} --image-family ubuntu-1710 --image-project ubuntu-os-cloud --preemptible --machine-type #{type} --zone #{zone} --project #{project} --boot-disk-size #{disk_size}GB"
      end

      def provision
        file = context.options.raw.ssh_key_file

        if @context.options.create_instance?
          # Immediately after launching the instance, it takes time to start up, so it can not lead to SSH.
          puts "sleep 60 sec"
          sleep 60 # sec
        end

        # In order to execute Itamae, it is necessary to set up ssh config.
        puts run "gcloud compute config-ssh --remove --ssh-key-file #{file} --project #{project}"
        puts run "gcloud compute config-ssh --ssh-key-file #{file} --project #{project}"

        puts "Provision instance..."
        role_file = File.expand_path('../itamae/roles/remote.rb', __FILE__)
        node_yaml = context.options.raw.node_yaml
        Itamae::Runner.run([role_file], :ssh, {
          host: "#{name}.#{zone}.#{project}",
          node_yaml: node_yaml,
          color: false,
          sudo: true,
          shell: "/bin/sh",
          log_level: "info",
        })
      end

      def delete
        puts "Delete instance..."
        puts run "gcloud compute instances delete #{name} --delete-disks all --quiet --zone #{zone} --project #{project}"
      end

      def restart
        puts "Reset instance..."
        puts run "gcloud compute instances reset #{name} --zone #{zone} --project #{project}"
        puts "Start instance..."
        puts run "gcloud compute instances start #{name} --zone #{zone} --project #{project}"
      end
    end
  end
end
