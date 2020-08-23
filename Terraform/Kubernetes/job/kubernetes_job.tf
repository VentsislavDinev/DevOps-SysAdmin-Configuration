resource "kubernetes_job" "demo" {
  metadata {
    name = "${var.job_metadata_name}"
  }
  spec {
    template {
      metadata {}
      spec {
        container {
          name    = "${var.job_spec_template_spec_container_name}"
          image   =  "${var.job_spec_template_spec_container_image}"
          command = "${var.job_spec_template_spec_container_command}"
        }
        restart_policy = "${var.job_spec_template_spec_restart_policy}"
      }
    }
    backoff_limit = "${var.job_spec_template_spec_backoff_limit}"
  }
  wait_for_completion = "${var.job_spec_template_spec_wait_for_completion}"
}