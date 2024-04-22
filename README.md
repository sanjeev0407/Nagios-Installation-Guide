# Nagios-Installation-Guide
A step-by-step guide to installing Nagios on Ubuntu.
##Table of Contents##
Introduction
Prerequisites
Installation
Configuration
Accessing Nagios
Troubleshooting
Contributing
License
Contact
Introduction

Nagios is a powerful monitoring system that enables organizations to identify and resolve IT infrastructure problems before they affect critical business processes. 
This guide will walk you through the installation process of Nagios on an Ubuntu system.

Prerequisites
Before you begin, ensure you have the following prerequisites installed:

Ubuntu 20.04 LTS
sudo access
Internet connection
Installation
Open a terminal and run the following commands to install Nagios:

bash
Copy code
# Update package lists
sudo apt update

# Install necessary packages
sudo apt install -y wget build-essential apache2 php openssl perl make php-cli php-gd libgd-dev libapache2-mod-php libperl-dev libssl-dev daemon

# Add Nagios user and group
sudo useradd nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo usermod -a -G nagcmd www-data

# Download Nagios source code
cd /opt
wget https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.6.tar.gz
tar -zxvf nagios-4.4.6.tar.gz

# Compile and install Nagios
cd nagioscore-nagios-4.4.6
./configure --with-httpd-conf=/etc/apache2/sites-enabled
make all
sudo make install
sudo make install-init
sudo make install-commandmode
sudo make install-config
sudo make install-webconf
Configuration
bash
Copy code
# Download Nagios plugins
cd /opt
wget https://nagios-plugins.org/download/nagios-plugins-2.3.3.tar.gz
tar -zxvf nagios-plugins-2.3.3.tar.gz
cd nagios-plugins-2.3.3

# Configure and install plugins
./configure --with-nagios-user=nagios --with-nagios-group=nagios
make
sudo make install

# Enable Apache modules
sudo a2enmod rewrite
sudo a2enmod cgi

# Restart Apache
sudo systemctl restart apache2

# Create Nagios admin user
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

# Start and enable Nagios service
sudo systemctl start nagios
sudo systemctl enable nagios
Accessing Nagios
You can now access the Nagios web interface by navigating to http://<your-server-ip>/nagios and logging in with the username nagiosadmin and the password you set during the installation.

Troubleshooting
If you encounter any issues during the installation, refer to the Nagios documentation or community forums for assistance.

Contributing
Contributions are welcome! Please fork the repository and submit a pull request with your changes.

License
This project is licensed under the MIT License.

Contact
For any questions or feedback, please contact:

Name: Sanjeev Kumar Anagandula
Email: sanjeevkumar.anagandula@gmail.com
