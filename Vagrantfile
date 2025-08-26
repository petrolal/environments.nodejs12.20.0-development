Vagrant.configure("2") do |config|

  # Box Image
  config.vm.box = "generic/arch"

  # Network in bridged mode
  config.vm.network "public_network", :dev => "wlan0"

  config.vm.synced_folder "./shared", "/vagrant_data", type: "rsync",
    rsync__args: ["--verbose", "--archive", "--delete", "-z"],
    rsync__exclude: [
      ".git/",
      "node_modules/",
      ".DS_Store",
      "*.log",
      "*.tmp",
      ".vagrant/",
      ".idea/",
      "vendor/",
      "dist/",
      "build/"
    ],
    rsync__auto: true

  # Trigger para sincronizar após provisionamento
  config.trigger.after :up do |trigger|
    trigger.run = {inline: "echo '📦 Sincronizando arquivos...'; vagrant rsync"}
  end

  # Função para lista de exclusões (opcional)
  def get_exclude_list
    [
      ".git/", "node_modules/", "vendor/", "dist/", "build/",
      "*.log", "*.tmp", ".DS_Store", ".vagrant/", ".idea/",
      "npm-debug.log*", "yarn-debug.log*", "yarn-error.log*"
    ]
  end

  # Provider Config 
  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = 1024
    libvirt.cpus = 2
    libvirt.driver = "kvm"
  end
  
  config.vm.provision "shell", path: "provision.sh"

end
