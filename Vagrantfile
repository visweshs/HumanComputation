# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network :forwarded_port, host: 3008, guest: 3000
  config.vm.network :forwarded_port, host: 2208, guest: 22, id: 'ssh', auto_correct: true
  config.vm.network :private_network, ip: "10.0.0.11"
  config.ssh.port = 2208

  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.provider :virtualbox do |vb|
    vb.name = "humancomp"

    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]

    vb.memory = 2048

    vb.cpus = 4
  end

  config.vm.provision :shell, :inline => "sudo apt-get update"
  config.vm.provision :shell, :inline => "sudo apt-get -y install build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool"
  config.vm.provision :shell, :inline => "sudo apt-get -y install libgmp-dev"
  config.vm.provision :shell, :inline => "sudo apt-get -y install nodejs"
  config.vm.provision :shell, :inline => "sudo apt-get -y install npm"
  config.vm.provision :shell, :inline => "sudo apt-get -y install libpq-dev"
  config.vm.provision :shell, :inline => "sudo apt-get -y install ntp"
  config.vm.provision :shell, :inline => "sudo timedatectl set-timezone EST"
  config.vm.provision :shell, privileged: false, inline: <<-SCRIPT
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable --quiet-curl --with-gems=bundler
    echo 'function syncdate () { sudo service ntp stop && sudo ntpdate ntp.ubuntu.com && sudo service ntp start ; }'  >> ~/.bash_profile
    echo 'cd /vagrant/' >> ~/.bash_profile
    echo 'export DISPLAY=localhost:10.0' >> ~/.bash_profile
  SCRIPT

  config.vm.provision :shell, privileged: false, inline: <<-SCRIPT
    source "$HOME/.rvm/scripts/rvm"
    rvm --quiet-curl install 2.2.3
    rvm use 2.2.3 --default
  SCRIPT

  config.vm.provision :shell, inline: <<-SCRIPT
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    apt-get update
    apt-get upgrade
    apt-get install -y git ntp postgresql-9.3 postgresql-server-dev-9.3 postgresql-contrib-9.3 nodejs phantomjs
    sudo -u postgres PGPASSWORD=postgres psql -U postgres -c "CREATE USER root WITH PASSWORD 'vagrant';"
    sudo -u postgres PGPASSWORD=postgres psql -U postgres -c "ALTER USER root CREATEDB; ALTER ROLE root SUPERUSER;"
    sudo -u postgres PGPASSWORD=postgres psql -U postgres -d template1 -c "CREATE EXTENSION hstore;"
    sudo -u postgres PGPASSWORD=postgres psql -U postgres -c "CREATE USER vagrant WITH PASSWORD 'vagrant';"
    sudo -u postgres PGPASSWORD=postgres psql -U postgres -c "ALTER ROLE vagrant SUPERUSER;"
    sudo -u postgres PGPASSWORD=postgres psql -U postgres -c "CREATE DATABASE humancomp_development;"
  SCRIPT

  config.vm.provision :shell, privileged: false, inline: <<-SCRIPT
    gem install bundler
  SCRIPT

  config.vm.provision :shell, privileged: false, inline: <<-SCRIPT
    bundle install --full-index -j4
    mkdir -p tmp
    bundle exec rake db:migrate
  SCRIPT
end
