data "helm_repository" "incubator" {
  name = "${var.get_data_name}"
  url  = "${var.get_data_url}"
}

resource "helm_release" "my_cache" {
  name       = "my-cache"
  repository = data.helm_repository.incubator.metadata[0].name
  chart      = "redis-cache"
}