#
# Cookbook:: rundeck
# Recipe:: rundeck_install
#
# Copyright:: 2018, The Authors, All Rights Reserved.

execute 'java' do
	command 'rpm -ivh https://s3.amazonaws.com/oracle-services/jdk-8u77-linux-x64.rpm'
end

execute 'install_run' do
	command 'rpm -Uvh http://rundeck.org/latest.rpm'
end

yum_package 'rundeck' do	
	action :install
end

bash 'rundeck_config' do
	code <<-EOH
		ip=$(curl --silent http://169.254.169.254/latest/meta-data/public-ipv4)
		sudo rm -rf /etc/rundeck/rundeck-config.properties
		echo "loglevel.default=INFO" >> /etc/rundeck/rundeck-config.properties
		echo "rdeck.base=/var/lib/rundeck" >> /etc/rundeck/rundeck-config.properties
		echo "rss.enabled=false" >> /etc/rundeck/rundeck-config.properties
		echo "grails.serverURL="$ip":4440" >> /etc/rundeck/rundeck-config.properties
		echo "dataSource.dbCreate=update" >> /etc/rundeck/rundeck-config.properties
		echo "dataSource.url=jdbc:mysql://localhost/rundeck?autoReconnect=true" >> /etc/rundeck/rundeck-config.properties
		echo "dataSource.username=rundeckuser" >> /etc/rundeck/rundeck-config.properties
		echo "dataSource.password=123456" >> /etc/rundeck/rundeck-config.properties
		EOH
		
service 'rundeckd' do
	action [ :enable, :start ]
end


