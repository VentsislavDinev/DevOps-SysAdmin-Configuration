#if you have variable file with auto generated variable, please use terraform apply -var-file="testing.tfvars"
# if you want change value for zone variable, please use terraform apply -var="zone=abc123"
variable "owner" {
    type = string
    description = "Bitbucket owner"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}

variable "repository" {
    type = string
    description = "Bitbucket owner"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}