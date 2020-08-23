# Creates the template in renders the variable
data "template_file" "foo_config_tpl" {
  template = "${file("foo.config.json.tpl")}"

  vars {
    port = "${var.foo_port}"
  }
}

# Creates the config
resource "docker_config" "foo_config" {
  name = var.config_name
  data = "${base64encode(data.template_file.foo_config_tpl.rendered)}"
}