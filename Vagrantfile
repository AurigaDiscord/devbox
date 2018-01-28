# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

# default box settings
Settings = {
  "memory" => 2048,
  "cpus"   => 2,
  "ip"     => "10.200.5.5",
}

# load possible non-default settings from YAML file
VargantVarsFile = File.join(File.expand_path(File.dirname(__FILE__)), "vagrant-vars.yml")
if File.exists?(VargantVarsFile)
  Settings = Settings.merge(YAML.load_file VargantVarsFile)
end

# box configuration
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.synced_folder "apps", "/apps", id: "apps"

  # provider specific configs
  config.vm.provider "parallels" do |prl|
    prl.customize ["set", :id,
                   "--cpus", Settings["cpus"],
                   "--memsize", Settings["memory"]]
    prl.check_guest_tools = true
    prl.update_guest_tools = true
  end

  config.vm.define :auriga do |cfg|
    cfg.vm.hostname = "auriga-devbox"
    cfg.vm.network :private_network, ip: Settings["ip"], type: "static"
  end

  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "auriga"
  end

end
