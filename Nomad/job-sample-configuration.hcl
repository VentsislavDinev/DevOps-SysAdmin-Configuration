# This declares a job named "docs". There can be exactly one
# job declaration per job file.
job "docs" {
  # Specify this job should run in the region named "us". Regions
  # are defined by the Nomad servers' configuration.
  region = "us"

  # Spread the tasks in this job between us-west-1 and us-east-1.
  datacenters = ["us-west-1", "us-east-1"]
  #If specified at the job level, the configuration will apply to all groups within the job. Only service jobs with a count greater than 1 support migrate stanzas.
  migrate {
    max_parallel     = 1
    health_check     = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }
  # All tasks in this job must be run on linux
  constraint  {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }
  # Run this job as a "service" type. Each job type has different
  # properties. See the documentation below for more examples.
  type = "service"

  # Specify this job to have rolling updates, two-at-a-time, with
  # 30 second intervals.
  update {
    stagger      = "30s"
    max_parallel = 2
  }

  # Group for unzip sample tar.gz archives
  group "sample"{
      task "unzip"{
          # unpack a remote resource, such as a file, tarball, or binary
          # Nomad downloads artifacts using the go-getter lib.
          artifact {
            source      = "https://example.com/file.tar.gz"
            destination = "local/some-directory"
            options {
                checksum = "md5:df6a4178aec9fbdc1d6d7e3634d1bc33"
            }
          }
      }
    
  }

  # A group defines a series of tasks that should be co-located
  # on the same client (host). All tasks within a group will be
  # placed on the same host.
  group "webs" {
    # Specify the number of these tasks we want.
    count = 5

    # set this group in periodic configurations. 
    periodic {
      cron             = "*/15 * * * * *"
      prohibit_overlap = true
    }

    # Create an individual task (unit of work). This particular
    # task utilizes a Docker container to front a web application.
    task "frontend" {
      # Specify the driver to be "docker". Nomad supports
      # multiple drivers.
      driver = "docker"

      # Configuration is specific to each driver.
      config {
        image = "hashicorp/web-frontend"
      }

      # The service block tells Nomad how to register this service
      # with Consul for service discovery and monitoring.
      service {
        # This tells Consul to monitor the service on the port
        # labelled "http". Since Nomad allocates high dynamic port
        # numbers, we use labels to refer to them.
        port = "http"
        name = "count-api"
        
        connect {
            sidecar_service {
              proxy {
                #These listeners create a bypass of the Connect TLS and network namespace isolation, enabling non-Connect enabled services to make requests to specific HTTP paths through the sidecar proxy.
                expose {
                  path {
                    path            = "/health"
                    protocol        = "http"
                    local_path_port = 9001
                    listener_port   = "api_expose_healthcheck"
                  }
                }
              }
            }
        }

        check {
          type     = "http"
          path     = "/health"
          interval = "10s"
          timeout  = "2s"
        }
      }

      # It is possible to set environment variables which will be
      # available to the task when it runs.
      env {
        "DB_HOST" = "db01.example.com"
        "DB_USER" = "web"
        "DB_PASS" = "loremipsum"
      }

      # Specify the maximum resources required to run the task,
      # include CPU, memory, and bandwidth.
      resources {
        cpu    = 500 # MHz
        memory = 128 # MB

        network {
          mbits = 100

          # This requests a dynamic port named "http". This will
          # be something like "46283", but we refer to it via the
          # label "http".
          port "http" {}

          # This requests a static port on 443 on the host. This
          # will restrict this task to running once per host, since
          # there is only one port 443 on each host.
          port "https" {
            static = 443
          }
        }
      }
    }
    #Logging is enabled by default with sane defaults (provided in the parameters section below), and there is currently no way to disable logging for tasks.
    task "server" {
      logs {
        max_files     = 10
        max_file_size = 10
      }
      # network configuration with protocols and port. 
      network {
        port "http" {}
        port "https" {}
        port "lb" {
          static = 8889
        }
      }
    }
  }
  group "example" {
    # All tasks in this group should be scheduled on different hosts.
    constraint {
      operator  = "distinct_hosts"
      value     = "true"
    }

    task "storage" {
      #Ephemeral disks can be marked as sticky and support live data migrations. 
      ephemeral_disk {
        migrate = true
        size    = "500"
        sticky  = true
      }
    }

    task "server" {
      # All tasks must run where "my_custom_value" is greater than 3.
      constraint {
        attribute = "${meta.my_custom_value}"
        operator  = ">"
        value     = "3"
      }

      resources {
        device "nvidia/gpu" {
          count = 2
          
          constraint {
            attribute = "${device.attr.memory}"
            operator  = ">="
            value     = "2 GiB"
          }

          affinity {
            attribute = "${device.attr.memory}"
            operator  = ">="
            value     = "4 GiB"
            weight    = 75
          }
        }
      }
      # The payload will be written to the configured file before the task is started. This allows the task to use the payload as input or configuration.
      dispatch_payload {
        file = "config.json"
      }
    }

    task "logging" {
      #Lifecycle task hooks are run in relation to the main tasks. Tasks can be run as Prestart Hooks, which ensures the prestart task is run before the main tasks are run.
      lifecycle {
        hook    = "prestart"
        sidecar = true
      }
    }

  }
}