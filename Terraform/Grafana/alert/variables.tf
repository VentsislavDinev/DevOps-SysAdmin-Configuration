variable "alert_notification_email" {
    type = string
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}

variable "lert_notification_type" {
    type = string
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}

variable "lert_notification_is_default" {
    type = bool
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}


variable "lert_notification_settings_addresses" {
    type = string
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
variable "lert_notification_settings_uploadImage" {
    type = string
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}