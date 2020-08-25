job "countdash" {
  datacenters = ["dc1"]
  # Prefer nodes in the us-west1 datacenter
  affinity {
    attribute = "${node.datacenter}"
    value     = "us-west1"
    weight    = 100
  }

  group "api" {
    network {
      mode = "bridge"
    }

    service {
      name = "count-api"
      port = "9001"

      connect {
        sidecar_service {}
      }
    }

    task "web" {
      driver = "docker"

      config {
        image = "hashicorpnomad/counter-api:v1"
      }
    }
  }

  group "dashboard" {
    network {
      mode = "bridge"

      port "http" {
        static = 9002
        to     = 9002
      }
    }

    service {
      name = "count-dashboard"
      port = "9002"

      connect {
        sidecar_service {
          proxy {
            upstreams {
              destination_name = "count-api"
              local_bind_port  = 8080
            }
          }
        }
      }
    }  
    
    # Prefer the "r1" rack
    affinity {
      attribute  = "${meta.rack}"
      value     = "r1"
      weight    = 50
    }

    task "dashboard" {
      driver = "docker"

      env {
        COUNTING_SERVICE_URL = "http://${NOMAD_UPSTREAM_ADDR_count_api}"
      }

      config {
        image = "hashicorpnomad/counter-dashboard:v1"
      }
    }
  }

  group "mysqld" {
    #restart the current grup. 
    restart {
      attempts = 3
      delay    = "10s"
      interval = "10m"
      mode     = "fail"
    }

    task "server" {
      service {
        tags = ["leader", "mysql"]

        port = "db"

        #chek the current task.
        check {
          type     = "tcp"
          port     = "db"
          interval = "10s"
          timeout  = "2s"
        }
        # check and restart the service 
        check {
          type     = "script"
          name     = "check_table"
          command  = "/usr/local/bin/check_mysql_table_status"
          args     = ["--verbose"]
          interval = "60s"
          timeout  = "5s"

          check_restart {
            limit = 3
            grace = "90s"
            ignore_warnings = false
          }
        }
      }
    }
  }
  group "api" {
    network {
      mode = "bridge"
    }
    service {
      name = "count-api"
      port = "9001"

      connect {
        sidecar_service {}
      }
    }

    task "web" {
      driver = "docker" 
      config {
        image = "hashicorpnomad/counter-api:v2"
      }
    }
  }
}