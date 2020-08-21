#if you have variable file with auto generated variable, please use terraform apply -var-file="testing.tfvars"
# if you want change value for zone variable, please use terraform apply -var="zone=abc123"
variable "bitbucket_user" {
    type = string
    description = "Bitbucket username"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
# if you want change value for description variable, please use terraform apply -var="name=abc123"
variable "description" {
    type = string
    description = "Description for the Bitcucket repo"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
# if you want change value for url variable, please use terraform apply -var="cname=abc123"
variable "urk" {
    type = string
    description = "url record text"
    # validate url variable   
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The url value must be a valid."
    }
}
# if you want change value for ttl variable, please use terraform apply -var="cname=abc123"
variable "ttl" {
    # validate tll variable
     validation {
        condition     = length(var.name) > 4 && substr(var.name, 0, 4)
        error_message = "The name value must be a valid."
    }
    type = number
    description = "TTL time"
}
