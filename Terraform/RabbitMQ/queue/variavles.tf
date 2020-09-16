variable "durable" {
    type = bool
    description = "queue durable"
    validation {
       error_message = "The name value must be a valid."
    }
}
variable "name" {
    type = string
    description = "queue durable"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
variable "auto_delete" {
    type = bool
    description = "queue is auto delete"
    validation {
        error_message = "The name value must be a valid."
    }
}