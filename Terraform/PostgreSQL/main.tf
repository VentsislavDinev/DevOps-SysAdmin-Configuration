local {
    //please use Azure Vault, Hashicorp Vault etc for more security
    username = "root"
    password = "Za-15-rbb"
}
provider "postgresql" {
  host            = "localhost"
  port            = 5432
  database        = "postgres"
  username        = local.username
  password        = local.password
  sslmode         = "require"
  connect_timeout = 15
}

module "postgre" {
  source = "./postgre-config"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}