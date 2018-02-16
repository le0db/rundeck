#
# Cookbook:: rundeck
# Recipe:: mysql_install
#
# Copyright:: 2018, The Authors, All Rights Reserved.

execute 'mysql_repo' do
	command 'rpm -ivh http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm'
end	

yum_package 'mysql-server' do
	action :install
end

service 'mysqld' do	
	action :start
end

execute 'root_pass_def' do	
	command 'mysqladmin password "12345"'
end

execute 'config_db' do
	command 'mysql -h localhost -u root -p12345 -bse "CREATE DATABASE rundeck;"'
end

execute 'create_user' do
	command 'mysql -h localhost -u root -p12345 -bse "grant ALL on rundeck.* to rundeckuser@localhost identified by \'123456\'"'
end


