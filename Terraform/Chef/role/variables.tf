
variable "chef_node_name" {
    type = string
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}
variable "chef_run_list" {
    type = list(string)
    description = "vhost name"
    validation {
        condition     = length(var.name) > 30 && substr(var.name, 0, 30)
        error_message = "The name value must be a valid."
    }
}

