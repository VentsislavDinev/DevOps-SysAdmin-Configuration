resource "kubernetes_cron_job" "demo" {
  metadata {
    name =  "${var.cron_job_metadata_name}"
  }
  spec {
    concurrency_policy            = "${var.cron_job_spec_concurrency_policy}"
    failed_jobs_history_limit     = "${var.cron_job_spec_failed_jobs_history_limit}"
    schedule                      = "${var.cron_job_spec_schedule}"
    starting_deadline_seconds     =  "${var.cron_job_spec_starting_deadline_seconds}"
    successful_jobs_history_limit =  "${var.cron_job_spec_successful_jobs_history_limit}"
    suspend                       = "${var.cron_job_spec_successful_jobs_history_limit}"
    job_template {
      metadata {}
      spec {
        backoff_limit = "${var.cron_job_spec_job_template_spec_backoff_limit}"
        ttl_seconds_after_finished    = "${var.cron_job_spec_job_template_spec_ttl_seconds_after_finished}"
        template {
          metadata {}
          spec {
            container {
              name    = "${var.cron_job_spec_job_template_spec_template_spec_container_name}"
              image   = "${var.cron_job_spec_job_template_spec_template_spec_container_image}"
              command = "${var.cron_job_spec_job_template_spec_template_spec_container_command}"
            }
            restart_policy = "${var.cron_job_spec_job_template_spec_template_spec_restart_policy}"
          }
        }
      }
    }
  }
}