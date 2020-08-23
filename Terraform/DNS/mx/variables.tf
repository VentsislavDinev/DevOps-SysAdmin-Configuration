
variable "mx_record_zone" {
    type = string
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}


variable "mx_record_preference" {
    type = number
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}


variable "mx_record_exchange" {
    type = string
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}


variable "mx_record_depends_on" {
    type = list(string)
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}

variable "mx_record_ttl" {
    type = number
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
