resource "chef_role" "example" {
    name     = "${var.chef_node_name}"
    run_list         = ["${var.chef_run_list}"]
}