
variable "grant_privileges" {
    type = list(string)
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}

variable "grant_database" {
    type = string
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}

variable "grant_host" {
    type = string
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}

variable "grant_user" {
    type = string
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
