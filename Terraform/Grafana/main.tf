local {
    //please use Azure Vault, Hashicorp Vault etc for more security
    password = "Za-15-rbb"
}
provider "grafana" {
  url  = "http://grafana.example.com/"
  auth = local.password
}
module "grafana" {
  source = "./grafana-config"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}