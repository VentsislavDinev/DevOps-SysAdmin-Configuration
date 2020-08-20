#
# Cookbook Name:: lamp_stack
# Recipe:: default
#
#

execute "update-upgrade" do 
    command "sudo apt-get update && sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade"
    action :run
end

#Add lamp stack to the Chef server 
#knife cookbook upload lamp_stack 
#verity that recipe has been add to the Chef server 
#knife cookbook list 
#add the recipe your chosen run list
#knife node run_list add nodename "recipe[lamp_stack]"
#From your workstation, apply the configurations defined in the cookbook by running the chef-client on your node.
#knife ssh 'name:nodename' 'sudo chef-client' -x root
#to test the Apache recipe,     update the LAMP Stack recipe on the server
#knife cookbook upload lamp_stack
#add the recipe to a node's run-list
#knife node run_list add nodename "recipe[lamp_stack::apache]

#From your workstation, apply the configurations defined in the cookbook by running the chef-client on your node.
#knife ssh 'name:nodename' 'sudo chef-client' -x root
#after a successful chef-client run, check to see if Apache is running:
#knife ssh 'name:nodename' 'systemctl status apache2' -x root
#Because multiple websites may need to be configured, use Chef’s attributes feature to define certain aspects of the virtual host file(s). The ChefDK has a built-in command to generate the attributes directory and default.rb file within a cookbook. Replace ~/chef-repo/cookbooks/lamp_stack with your cookbook’s path:
#chef generate attribute ~/chef-repo/cookbooks/lamp_stack default
#The template feature will be used to generate the needed virtual host files. Within the chef-repo directory run the chef generate template command with the path to your cookbook and template file name defined:
#chef generate template ~/chef-repo/cookbooks/lamp_stack virtualhosts

#The Chef Supermarket has an OpsCode-maintained MySQL cookbook that sets up MySQL lightweight resources/providers (LWRPs) to be used. From the workstation, download and install the cookbook:
#knife cookbook site install mysql
#Upload these cookbooks to the server:
#knife cookbook upload mysql --include-dependencies
#On the workstation, generate a secret key:
#openssl rand -base64 512 > ~/chef-repo/.chef/encrypted_data_bag_secret
#On the workstation, create a mysql data bag that will contain the file rtpass.json for the root password:
#knife data bag create mysql rtpass.json --secret-file ~/chef-repo/.chef/encrypted_data_bag_secret

#Confirm that the rtpass.json file was created:
#knife data bag show mysql

#It should output rtpass.json. To ensure that is it encrypted, run:
#knife data bag show mysql rtpass.json

#Ensure that your Chef server contains the updated cookbook, and that your node’s run list is up-to-date. Replace nodename with your Chef node’s name:
#knife cookbook upload lamp_stack
#knife node run_list add nodename "recipe[lamp_stack],recipe[lamp_stack::apache],recipe[lamp_stack::mysql],recipe[lamp_stack::php]"
#To ensure that the Apache service has been successfully installed and running, you can execute the following command, substituting node_name for the name of your node:
#knife ssh 'name:node_name' 'systemctl status apache2' -x root

#Upload your cookbook to your Chef server, and then run chef-client on your node, replacing node_name with the name of your node:
#knife cookbook upload lamp_stack
#knife ssh 'name:node_name' 'sudo chef-client' -x root
#To test your MySQL installation, you can check on the status of MySQL using systmectl. Issue the following command to ensure the MySQL service is running correctly:
#knife ssh 'name:node_name' 'systemctl status mysql-mysqldefault' -u root
