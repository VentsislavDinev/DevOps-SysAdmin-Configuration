#if you have variable file with auto generated variable, please use terraform apply -var-file="testing.tfvars"
# if you want change value for zone variable, please use terraform apply -var="zone=abc123"
variable "bitbucket_branch_restriction_owner" {
    type = string
    description = "Bitbucket restriction owner"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}

variable "bitbucket_branch_restriction_repo" {
    type = string
    description = "Bitbucket restriction repo"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
variable "bitbucket_branch_restriction_kind" {
    type = string
    description = "Bitbucket restriction kind"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
variable "bitbucket_branch_restriction_pattern" {
    type = string
    description = "Bitbucket restriction pattern"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}