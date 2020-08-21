
variable "bitbucket_project_owner" {
    type = string
    description = "Bitbucket project owner"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}

variable "bitbucket_project_name" {
    type = string
    description = "Bitbucket project name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}

variable "bitbucket_project_key" {
    type = string
    description = "Bitbucket project key"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
