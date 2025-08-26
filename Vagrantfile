Vagrant.configure("2") do |config|

  # Box Image
  config.vm.box = "generic/arch"

  # Network in bridged mode
  config.vm.network "public_network", :dev => "wlan0"

  # Foward deafult node ports
  config.vm.network "forwarded_port", guest: 4200, host: 4200
  config.vm.network "forwarded_port", guest: 8100, host: 8100
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  
  config.vm.synced_folder "./shared", "/vagrant", type: "rsync",
    rsync__args: [
      "--verbose",           # Mostrar o que está sincronizando
      "--archive",           # Modo arquivo (preserva permissões)
      "--delete",            # Deletar arquivos removidos
      "-z",                  # Comprimir durante transferência
      "--chmod=Du=rwx,Dg=rx,Do=rx,Fu=rw,Fg=r,Fo=r"  # Permissões:attr_writer :attr_names
    ],
    rsync__exclude: [
      ".git/", "node_modules/", "vendor/", "dist/", "build/",
      "*.log", "*.tmp", ".DS_Store", ".vagrant/", ".idea/",
      "npm-debug.log*", "yarn-debug.log*", "yarn-error.log*"
    ],
    rsync__auto: true

  # Trigger para sincronizar após provisionamento
  config.trigger.after :up do |trigger|
    trigger.run = {inline: "echo '📦 Sincronizando arquivos...'; vagrant rsync"}
  end

  # Provider Config 
  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = 4096
    libvirt.cpus = 4
    libvirt.driver = "kvm"
  end
  
  config.vm.provision "shell", path: "provision.sh"

end
