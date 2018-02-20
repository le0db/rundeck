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

file '/etc/rundeck/rundeck-config.properties' do
	content '
loglevel.default=INFO
rdeck.base=/var/lib/rundeck
rss.enabled=false
grails.serverURL=http://52.91.231.62:4440
dataSource.dbCreate = update
dataSource.url = jdbc:mysql://localhost/rundeck?autoReconnect=true
dataSource.username=rundeckuser
dataSource.password=123456
'
end

service 'rundeckd' do
	action [ :enable, :start ]
end


