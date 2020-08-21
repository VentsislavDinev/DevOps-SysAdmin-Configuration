provider "kubernetes" {
  config_context = "my-context"
}

module "dns" {
  source = "./kubernetes-config"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}