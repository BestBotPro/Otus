Vagrant.configure("2") do |config|
  config.vm.box = "Debian-10"
  config.vm.provider "vmware_desktop" do |v|
    v.vmx["memsize"] = "1024"
    v.vmx["numvcpus"] = "1"
    v.vmx["scsi0:0.present"] = "TRUE"
    v.vmx["scsi0:0.fileName"] = "disk.vmdk"
    v.vmx["scsi0:0.redo"] = ""
    v.vmx["scsi0:0.capacity"] = "30720"
  end

  # Настройка сети (по умолчанию уже настроен на NAT)
  config.vm.network "public_network"

  # Настройка провижининга до перезагрузки
  config.vm.provision "shell", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive

    echo "Updating and installing necessary packages..."
    apt-get update
    apt-get install -y sudo ufw
    useradd -m -s /bin/bash pt && echo "User pt created successfully."
    echo 'pt:123' | chpasswd && echo "Password for pt changed successfully."
    usermod -aG sudo pt && echo "User pt added to sudo group successfully."

    ufw allow 22
    ufw --force enable && echo "UFW enabled and configured."

    echo "Kernel version before update:"
    uname -r

    apt-get upgrade -y
    apt-get dist-upgrade -y
    apt-get install -y linux-image-amd64

    apt-get autoremove -y
    apt-get clean

    echo "Rebooting the system to apply kernel updates..."
    # Запланировать перезагрузку после завершения скрипта
    (sleep 2 && reboot) &
  SHELL

  # Настройка провижининга после перезагрузки
  config.vm.provision "shell", run: "always", inline: <<-SHELL
    echo "Kernel version after update:"
    uname -r
  SHELL
end
