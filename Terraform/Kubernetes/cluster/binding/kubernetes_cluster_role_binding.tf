resource "kubernetes_cluster_role_binding" "example" {
  metadata {
    name = "${var.cluster_role_binding_metadata_name}"
  }
  role_ref {
    api_group = "${var.cluster_role_binding_role_ref_api_group}"
    kind      = "${var.cluster_role_binding_role_ref_kind}"
    name      = "${var.cluster_role_binding_role_ref_name}"
  }
  subject {
    kind      =  "${var.cluster_role_binding_subject_kind}"
    name      =  "${var.cluster_role_binding_subject_name}"
    api_group =  "${var.cluster_role_binding_subject_api_group}"
  }
  subject {
    kind      =  "${var.cluster_role_binding_subject_kind}"
    name      =  "${var.cluster_role_binding_subject_name}"
    namespace =  "${var.cluster_role_binding_subject_namespace}"
  }
  subject {   
    kind      =  "${var.cluster_role_binding_subject_kind}"
    name      =  "${var.cluster_role_binding_subject_name}"
    namespace =  "${var.cluster_role_binding_subject_namespace}"
  }
}