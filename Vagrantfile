# -*- mode: ruby -*-
# vi: set ft=ruby :
# NOTE: Variable overrides are in ./config.rb
require "yaml"
require "fileutils"

# Use a variable file for overrides:
CONFIG = File.expand_path("config.rb")
if File.exist?(CONFIG)
  require CONFIG
end

# Force best practices for this environment:
if $box_memory < 512
  puts "WARNING: Your machine should have at least 512 MB of memory"
end

# Install any Required Plugins
missing_plugins_installed = false
required_plugins = %w(vagrant-env vagrant-git)

required_plugins.each do |plugin|
  if !Vagrant.has_plugin? plugin
    system "vagrant plugin install #{plugin}"
    missing_plugins_installed = true
  end
end

# If any plugins were missing and have been installed, re-run vagrant
if missing_plugins_installed
  exec "vagrant #{ARGV.join(" ")}"
end

# Vagrantfile API/sytax version. Don’t touch unless you know what you’re doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.define vm_name = "DevBox" do |node|
      node.vm.box = $box_name
      node.vm.hostname = "DevBox"
      
      # Virtualbox Provider (Default --provider=virtualbox):
      node.vm.provider "virtualbox" do |vb|
        vb.name = "DevBox"
        vb.customize ["modifyvm", :id, "--memory", $box_memory]
        vb.customize ["modifyvm", :id, "--cpus", $box_vcpus]
      end

  # We only want Ansible to run after after all servers are deployed:
	#Checks if platform is Windows, if TRUE runs Ansible from within virtual machine
	if Vagrant::Util::Platform.windows?
		config.vm.provision :guest_ansible do |ansible|
		  ansible.sudo              = true
      ansible.limit             = $ansible_limit
      ansible.playbook          = $ansible_playbook
      ansible.host_key_checking = false    		
	   end
  	else
    		config.vm.provision :ansible do |ansible|
      		ansible.sudo              = true
        	ansible.limit             = $ansible_limit
        	ansible.playbook          = $ansible_playbook
        	ansible.host_key_checking = false
    	   end
  	end

    # We only want Ansible to run after after all servers are deployed:
        # Additional Ansible tools for debugging:
        #ansible.inventory_path = $ansible_inventory
        #ansible.verbose        = "-vvvv"
        #ansible.raw_ssh_args   = ANSIBLE_RAW_SSH_ARGS
      end

