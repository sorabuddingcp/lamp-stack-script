
#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

# Update packages and Upgrade system
echo -e "$Cyan \n Updating System.. $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

## Install AMP
echo -e "$Cyan \n Installing Apache2 $Color_Off"
sudo apt-get install apache2 -y

echo -e "$Cyan \n Installing PHP & Requirements $Color_Off"
sudo apt-get install php7.0 php7.0-common php7.0-curl php7.0-dev libapache2-mod-php7.0 php7.0-gd php7.0-mcrypt php7.0-mysql php7.0-xml php7.0-mysql -y


echo -e "$Cyan \n Installing MySQL $Color_Off"


#The following commands set the MySQL root password to MYPASSWORD123 when you install the mysql-server package.
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get install mysql-server mysql-client -y


echo -e "$Cyan \n Verifying installs$Color_Off"
#sudo apt-get install apache2  php7.0-gd -y


#echo -e "$Cyan \n Installing phpMyAGdmin $Color_Off"
#sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/root_password password password'
#sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/root_password_again password password'
echo -e "\e[93m User: root, Password: root \e[39m"
# Set non-interactive mode
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'﻿

sudo apt-get -y install phpmyadmin

#https://gist.github.com/ankurk91/16a3d36b1afa3f9c91f02828adfedf6f

#sudo apt-get install phpmyadmin -y

## TWEAKS and Settings
# Permissions
echo -e "$Cyan \n Permissions for /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www/html

echo -e "$Green \n Permissions have been set $Color_Off"
sudo chmod 755 -R /var/www/html;

# Enabling Mod Rewrite, required for WordPress permalinks and .htaccess files
echo -e "$Cyan \n Enabling Modules $Color_Off"
sudo a2enmod rewrite

sudo printf "<?php\nphpinfo();\n?>" > /var/www/html/info.php;

# Restart Apache
echo -e "$Cyan \n Restarting Apache $Color_Off"
sudo service apache2 restart

#Back-up apache2 configure file
if [ ! -f /etc/apache2/apache2.conf.orig ]; then
    printf "Backing up original configuration file to /etc/apache2/apache2.conf.orig\n"
    cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.orig
	printf "Backing up original configuration file to /etc/apache2/apache2.conf.orig\n"
	cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.orig
 fi

# Download and install composer 
echo -e "\e[96m Installing composer \e[39m"
# Notice: Still using the good old way
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer


# Check php version
php -v

# Check apache version
apachectl -v

# Check mysql version
mysql --version

# Check if php is working or not
php -r 'echo "\nYour PHP installation is working fine.\n";'

# Fix composer folder permissions
#sudo chown -R $USER $HOME/.composer

# Check composer version
composer --version

echo -e "\e[92m Open http://localhost/ to check if apache is working or not. \e[39m"

# Clean up cache
sudo apt-get clean




#https://aplicadordetexturaegrafiato.com/autoresponder/guideline/#21-installation-with-cpanel
