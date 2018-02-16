#
# Cookbook:: rundeck
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

execute 'att_os' do
	command 'yum update -y'
	user 'root'
end


