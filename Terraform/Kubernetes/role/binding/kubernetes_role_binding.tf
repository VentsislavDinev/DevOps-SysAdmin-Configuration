resource "kubernetes_role_binding" "example" {
  metadata {
    name      = "${var.role_binding_metadata_name}"
    namespace = "${var.role_binding_metadata_namespace}"
  }
  role_ref {
    api_group =  "${var.role_binding_role_ref_api_group}"
    kind      = "${var.role_binding_role_ref_kind}"
    name      =  "${var.role_binding_role_ref_name}"
  }
  subject {
    kind      = "${var.role_binding_subject_kind}"
    name      =  "${var.role_binding_subject_name}"
    api_group = "${var.role_binding_subject_api_group}"
  }
}