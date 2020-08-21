#if you have variable file with auto generated variable, please use terraform apply -var-file="testing.tfvars"
# if you want change value for zone variable, please use terraform apply -var="zone=abc123"
variable "chef_data_bag" {
    type = string
    description = "Chef data bag"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
# if you want change value for name variable, please use terraform apply -var="name=abc123"
variable "chef_run_list" {
    type = string
    description = "Run list command"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
# if you want change value for cname variable, please use terraform apply -var="cname=abc123"
variable "chef_node_name" {
    type = string
    description = "node name"
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
