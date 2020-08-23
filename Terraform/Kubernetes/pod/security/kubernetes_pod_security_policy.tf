resource "kubernetes_pod_security_policy" "example" {
  metadata {
    name = "${var.pod_security_policy_metadata_name}"
  }
  spec {
    privileged                 = "${var.pod_security_policy_privileged}"
    allow_privilege_escalation = "${var.pod_security_policy_allow_privilege_escalation}"

    volumes = "${var.pod_security_policy_volumes}"

    run_as_user {
      rule =  "${var.pod_security_policy_run_as_user_rule}"
    }

    se_linux {
      rule =   "${var.pod_security_policy_se_linux_rule}"
    }

    supplemental_groups {
      rule   =  "${var.pod_security_policy_supplemental_groups_rule}"
      range {
        min =  "${var.pod_security_policy_supplemental_groups_range_min}"
        max = "${var.pod_security_policy_supplemental_groups_range_max}"
      }
    }

    fs_group {
      rule   =  "${var.pod_security_policy_fs_group_rule}"
      range {
        min =  "${var.pod_security_policy_fs_group_range_min}"
        max =  "${var.pod_security_policy_fs_group_range_max}"
      }
    }

    read_only_root_filesystem =   "${var.pod_security_policy_fs_group_range_read_only_root_filesystem}"
  }
}