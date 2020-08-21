provider "dns" {
  version = "2.2.0"
}

module "dns" {
  source = "./dns-config"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}