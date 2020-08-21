local {
    //please use Azure Vault, Hashicorp Vault etc for more security
    username = "root"
    password = "Za-15-rbb"
}
# Configure the MySQL provider
provider "mysql" {
  endpoint = "localhost:3306"
  username = local.username
  password = local.password
}

module "mysql" {
  source = "./mysql-config"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}