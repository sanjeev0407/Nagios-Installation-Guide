#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install -y wget build-essential apache2 php openssl perl make php-cli php-gd libgd-dev libapache2-mod-php libperl-dev libssl-dev daemon unzip

# Create Nagios user and group
sudo useradd nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo usermod -a -G nagcmd www-data

# Download and install Nagios Core
cd /opt
wget https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.6.tar.gz
tar -zxvf nagios-4.4.6.tar.gz
cd nagioscore-nagios-4.4.6
./configure --with-httpd-conf=/etc/apache2/sites-enabled
make all
sudo make install
sudo make install-init
sudo make install-commandmode
sudo make install-config
sudo make install-webconf

# Download and install Nagios Plugins
cd /opt
wget https://nagios-plugins.org/download/nagios-plugins-2.3.3.tar.gz
tar -zxvf nagios-plugins-2.3.3.tar.gz
cd nagios-plugins-2.3.3
./configure --with-nagios-user=nagios --with-nagios-group=nagios
make
sudo make install

# Enable Apache modules and restart Apache
sudo a2enmod rewrite
sudo a2enmod cgi
sudo systemctl restart apache2

# Set Nagios admin password
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

# Start and enable Nagios service
sudo systemctl start nagios
sudo systemctl enable nagios

# Cleanup downloaded files (optional)
# rm -rf /opt/nagios-4.4.6.tar.gz /opt/nagioscore-nagios-4.4.6 /opt/nagios-plugins-2.3.3.tar.gz /opt/nagios-plugins-2.3.3

echo "Nagios installation completed successfully!"


# Make sure to run this script with root privileges:
# chmod +x nagios_install.sh
# sudo ./nagios_install.sh

