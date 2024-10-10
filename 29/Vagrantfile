Vagrant.configure("2") do |config|
  config.vm.define "pxeserver" do |server|
    server.vm.box = 'ubuntu/jammy64'
    server.vm.host_name = 'pxeserver'
    server.vm.network "forwarded_port", guest: 80, host: 8080
    server.vm.network :private_network, ip: "10.0.0.20", virtualbox__intnet: 'pxenet'
    server.vm.network :private_network, ip: "192.168.56.10", adapter: 3
    server.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
    # Добавляем shell провижининг для установки Python
    server.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y python3
      # Создаем симлинк, если ansible ожидает python в /usr/bin/python
      if [ ! -f /usr/bin/python ]; then
          sudo ln -s /usr/bin/python3 /usr/bin/python
      fi
    SHELL
    server.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/provision.yml"
      
      ansible.host_key_checking = "false"
      ansible.limit = "all"
    end
  end

  config.vm.define "pxeclient1" do |pxeclient|
    pxeclient.vm.box = 'ubuntu/jammy64'
    pxeclient.vm.host_name = 'pxeclient'
    
    pxeclient.vm.network :private_network, ip: "10.0.0.21"
    pxeclient.vm.provider :virtualbox do |vb|
      vb.memory = "4096"
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ['modifyvm', :id, '--nic1', 'intnet', '--intnet1', 'pxenet', '--nic2', 'nat', '--boot1', 'net', '--boot2', 'none', '--boot3', 'none', '--boot4', 'none']
    end

  end
end
