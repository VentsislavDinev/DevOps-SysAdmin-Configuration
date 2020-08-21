
variable "bitbucket_repo_owner" {
    type = string
    description = "Bitbucket repo owner"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}

variable "bitbucket_repo_name" {
    type = string
    description = "Bitbucket repo name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}