local {
    //please use Azure Vault, Hashicorp Vault etc for more security
    username = "Za-15-rbb"
    password = ""
    config_file = ""
}
provider "docker" {
  host = "tcp://localhost:2376"

  registry_auth {
    address = "registry.hub.docker.com"
    config_file = local.config_file
  }

  registry_auth {
    address = "registry.my.company.com"
    config_file_content = "${var.plain_content_of_config_file}"
  }

  registry_auth {
    address = "quay.io:8181"
    username = local.username
    password = local.password
  }
}
module "docker" {
  source = "./docker-config"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}