resource "kubernetes_cluster_role" "example" {
  metadata {
    name = "${var.cluster_metadata_name}"
  }

  rule {
    api_groups = "${var.cluster_ruke_api_groups}"
    resources  = "${var.cluster_ruke_resources}"
    verbs      = "${var.cluster_ruke_verbs}"
  }
}