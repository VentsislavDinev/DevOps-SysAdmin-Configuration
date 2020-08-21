resource "chef_data_bag_item" "example" {
  data_bag_name = var.chef_data_bag

  content_json = <<EOT
{
    "id": "example-item",
    "any_arbitrary_data": true
}
EOT
}