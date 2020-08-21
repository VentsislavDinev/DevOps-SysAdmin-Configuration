#if you have variable file with auto generated variable, please use terraform apply -var-file="testing.tfvars"
# if you want change value for zone variable, please use terraform apply -var="zone=abc123"
variable "container_name" {
    type = string
    description = "Domain zone name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
# if you want change value for name variable, please use terraform apply -var="name=abc123"
variable "name" {
    type = string
    description = "Name for the domain zone"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
# if you want change value for cname variable, please use terraform apply -var="cname=abc123"
variable "cname" {
    type = string
    description = "CNAME record text"
    # validate cname variable   
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The cname value must be a valid."
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
