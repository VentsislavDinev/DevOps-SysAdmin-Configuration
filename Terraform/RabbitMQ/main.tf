local {
    //please use Azure Vault, Hashicorp Vault etc for more security
    username = "root"
    password = "Za-15-rbb"
}
# Configure the RabbitMQ provider
provider "rabbitmq" {
  endpoint = "http://127.0.0.1"
  username = local.username
  password = local.password
}

module "rabbitmq" {
  source = "./rabbitmq-config"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}