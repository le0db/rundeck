#
# Cookbook:: rundeck
# Recipe:: terraform_install
#
# Copyright:: 2018, The Authors, All Rights Reserved.

directory '/opt/terraform' do
	action :create
end

execute 'download_terra' do
	command 'cd /opt/terraform && wget https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip?_ga=2.147082738.450913453.1519136803-1829457121.1513099639'
end 

execute 'install_terra' do
	command 'cd /opt/terraform && unzip terraform_0.11.3_linux_amd64.zip?_ga=2.147082738.450913453.1519136803-1829457121.1513099639'
end

file 'cd /opt/terraform/terraform_0.11.3_linux_amd64.zip?_ga=2.147082738.450913453.1519136803-1829457121.1513099639' do
	action :delete
end

bash 'env_variables' do
	code <<-EOH
	echo export PATH=$PATH:/opt/terraform >> /etc/profile
	echo export OPC_USERNAME=eduardo.rozario@rivendel.com.br >> /etc/profile
	echo export OPC_PASSWORD=KFU,P6sda%N{ >> /etc/profile
	echo export OPC_IDENTITY_DOMAIN=a430478 >> /etc/profile
	echo export OPC_ENDPOINT=https://compute.uscom-central-1.oraclecloud.com/ >> /etc/profile
	source /etc/profile
		EOH
end


