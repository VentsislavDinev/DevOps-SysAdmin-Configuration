local {
    //please use Azure Vault, Hashicorp Vault etc for more security
    client_name = "Za-15-rbb"
}
# Configure the Chef provider
provider "chef" {
  server_url = "https://api.chef.io/organizations/example/"

  # You can set up a "Client" within the Chef Server management console.
  client_name  = local.client_name
  key_material = "${file("chef-terraform.pem")}"
}
module "chef" {
  source = "./chef-config"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}