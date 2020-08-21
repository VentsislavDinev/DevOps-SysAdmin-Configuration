local {
    //please use Azure Vault, Hashicorp Vault etc for more security
    username = "root"
    password = "Za-15-rbb"
}
provider "helm" {
  kubernetes {
    host     = "https://104.196.242.174"
    username = local.username
    password = local.password

    client_certificate     = file("~/.kube/client-cert.pem")
    client_key             = file("~/.kube/client-key.pem")
    cluster_ca_certificate = file("~/.kube/cluster-ca-cert.pem")
  }
}
module "heml" {
  source = "./dns-config"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}