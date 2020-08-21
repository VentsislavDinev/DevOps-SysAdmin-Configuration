local {
    //please use Azure Vault, Hashicorp Vault etc for more security
    username = "Za-15-rbb"
    password = "Za-15-rbb"
}
# Configure the Bitbucket Provider
provider "bitbucket" {
  username = local.username
  password = local.password
}
module "bitbucket" {
  source = "./bitbucket-config"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}

module "bitbucket_default_reviewers" {
  source = "./bitbucket_default_reviewers"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}


module "bitbucket_branch_restriction" {
  source = "./bitbucket_branch_restriction"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}

module "bitbucket_project" {
  source = "./bitbucket_project"
  version = "0.0.1"
  #if you want use in multiple servers, please use: server = count
  #servers = 5
}


