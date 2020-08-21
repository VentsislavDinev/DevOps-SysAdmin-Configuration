
resource "docker_service" "foo" {
  name = var.service_name

  task_spec {
    container_spec {
      image = var.service_image_name

      labels {
        label = var.service_label
        value = var.service_value
      }

      command  = var.service_command
      args     = var.service_args
      hostname = var.service_hostname

      env = {
        MYFOO = var.service_env
      }

      dir    = var.service_dir
      user   = var.service_user
      groups = var.service_groups

      privileges {
        se_linux_context {
          disable = var.service_privileges_linux_context_disable
          user    = var.service_privileges_linux_context_user
          role    = var.service_privileges_linux_context_role
          type    = var.service_privileges_linux_context_type
          level   = var.service_privileges_linux_context_level
        }
      }

      read_only =var.service_read_only

      mounts {
    target    = var.service_mounts_target
    source    = "${docker_volume.test_volume.name}"
    type      = var.service_mounts_type
    read_only = var.service_mounts_read_only

    bind_options {
      propagation = var.service_bind_options_propagation
        }
      }

      mounts {
    # another mount
      }

      stop_signal       =  var.service_stop_signal
      stop_grace_period =var.service_stop_grace_period

      healthcheck {
        test     = var.service_healthcheck_test
        interval = var.service_healthcheck_interval
        timeout  = var.service_healthcheck_timeout
        retries  = var.service_healthcheck_retries
      }

      hosts {
        host = var.service_hosts_host
        ip   = var.service_hosts_ip
      }

      dns_config {
        nameservers = var.service_dns_config_nameservers
        search      = var.service_dns_config_search
        options     = var.service_dns_config_options
      }

      secrets {
        secret_id   = "${docker_secret.service_secret.id}"
        secret_name = "${docker_secret.service_secret.name}"
        file_name   = var.service_secrets_file_name
        file_uid    = var.service_secrets_file_uid
    file_gid    = var.service_secrets_file_gid
    file_mode   =  var.service_secrets_file_mode
      }

      secrets {
        # another secret
      }

      configs {
        config_id   = "${docker_config.service_config.id}"
        config_name = "${docker_config.service_config.name}"
        file_name   =  var.service_configs_file_name
      }

      configs {
        # another config
      }
    }

    resources {
      limits {
        nano_cpus    = var.service_resources_limits_nano_cpus
        memory_bytes = var.service_resources_limits_memory_bytes

        generic_resources {
          named_resources_spec = [
            var.service_resources_limits_generic_resources_named_resources_spec
          ]

          discrete_resources_spec = [
            var.service_resources_limits_generic_resources_discrete_resources_spec
          
          ]
        }
      }

      reservation {
        nano_cpus    =  var.service_reservation_nano_cpus
          
        memory_bytes = var.service_reservation_memory_bytes

        generic_resources {
          named_resources_spec = [
            var.service_reservation_generic_resources_named_resources_spec
          ]

          discrete_resources_spec = [
            var.service_reservation_generic_resources_discrete_resources_spec
          ]
        }
      }
    }

    restart_policy = {
      condition    = var.service_reservation_restart_policy_condition
      delay        = var.service_reservation_restart_policy_delay
      max_attempts = var.service_reservation_restart_policy_max_attempts
      window       =  var.service_reservation_restart_policy_window
    }

    placement {
      constraints = [
        var.service_placement_constraints
      ]

      prefs = [
       var.service_placement_prefs
      ]
    }

    force_update = var.service_force_update
    runtime      =var.service_runtime
    networks     = ["${docker_network.test_network.id}"]

    log_driver {
      name = var.service_log_driver_name

      options {
        max-size = var.service_log_driver_options_max_size
        max-file = var.service_log_driver_options_max_file
      }
    }
  }

  mode {
    replicated {
      var.service_mode_replicated
    }
  }

  update_config {
    parallelism       = var.service_update_config_parallelism
    delay             = var.service_update_config_delay
    failure_action    = var.service_update_config_failure_action
    monitor           =var.service_update_config_monitor
    max_failure_ratio = var.service_update_config_max_failure_ratio
    order             = var.service_update_config_order
  }

  rollback_config {
    parallelism       = var.service_rollback_config_parallelism
    delay             = var.service_rollback_config_delay
    failure_action    = var.service_rollback_config_failure_action
    monitor           = var.service_rollback_config_monitor
    max_failure_ratio = var.service_rollback_config_max_failure_ratio
    order             = var.service_rollback_config_order
  }

  endpoint_spec {
    mode = var.service_endpoint_spec_mode

    ports {
      name           =var.service_ports_name
      protocol       = var.service_ports_protocol
      target_port    = var.service_ports_target_port
      published_port = var.service_ports_published_port
      publish_mode   = var.service_ports_publish_mode
    }

    ports {
      # another port
    }
  }
}