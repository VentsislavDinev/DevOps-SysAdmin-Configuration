resource "chef_node" "example" {
  name             = "${var.chef_node_name}"
  environment_name = "${chef_environment.example.name}"
  run_list         = var.chef_run_list
}