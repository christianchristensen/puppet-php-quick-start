# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "base"
  # config.vm.box_url = ""
  # https://github.com/cal/vagrant-ubuntu-precise-64 (with PR's #8, #11)

  # Disabled for compatibility: example shared folder configuration
  # config.vm.network :hostonly, "192.168.50.4"
  # config.vm.share_folder( "app-mnt1", "/srv/www", "./app", :nfs => true)
  # config.vm.share_folder( "app-mnt2", "/srv/localhost", "./app", :nfs => true)

  config.vm.host_name = "test.local.vagrant"
  config.vm.forward_port 80, 8080
  config.vm.provision :puppet, :module_path => "modules" do |puppet|
    puppet.options = "--verbose --debug"
    puppet.manifests_path = "."
    puppet.manifest_file  = "site.pp"
  end
end
