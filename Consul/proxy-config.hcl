Kind = "proxy-defaults"
Name = "global"
ConnectTimeout = "15s"
DefaultSubset = "v1"
MeshGateway {
   Mode = "local"
}
Subsets = {
  "v1" = {
    Filter = "Service.Meta.version == v1"
  }
  "v2" = {
    Filter = "Service.Meta.version == v2"
  }
}
Routes = [
    {
        Match {
        HTTP {
            Header = [
            {
                Name  = "x-debug"
                Exact = "1"
            }
            },
            PathPrefix = "/admin"
        }
        }

        Destination {
        Service = "admin"
        ServiceSubset = "canary"
        }
    },
    {
        Match {
        HTTP {
            QueryParam = [
            {
                Name  = "x-debug"
                Exact = "1"
            },
            ]
        }
        }
        Destination {
        Service       = "web"
        ServiceSubset = "canary"
        }
    },
    {
        Match {
        HTTP {
            PathExact = "/mycompany.BillingService/GenerateInvoice"
        }
        }

        Destination {
        Service = "invoice-generator"
        }
    },
  # NOTE: a default catch-all will send unmatched traffic to "web"
]
Splits = [
  {
    Weight        = 90
    ServiceSubset = "v1"
  },
  {
    Weight        = 10
    ServiceSubset = "v2"
  },
]
Failover = {
  "*" = {
    Datacenters = ["dc3", "dc4"]
  }
}
Redirect {
  Service    = "web"
  Datacenter = "dc2"
}
Config {
    protocol = "http"
    local_connect_timeout_ms = 1000
    handshake_timeout_ms = 10000
}


TLS {
  Enabled = true
}

Listeners = [
  {
    Port     = 8080
    Protocol = "http"
    Services = [
      {
        Name = "*"
      }
    ]
  },
  {
    Port     = 4567
    Protocol = "http"
    Services = [
      {
        Name  = "api"
        Hosts = ["foo.example.com", "foo.example.com:4567"]
      },
      {
        Name  = "web"
        Hosts = ["website.example.com", "website.example.com:4567"]
      }
    ]
  }
]


Services = [
    {
        Name   = "billing"
        CAFile   = "/etc/certs/ca-chain.cert.pem"
        KeyFile  = "/etc/certs/gateway.key.pem"
        CertFile = "/etc/certs/gateway.cert.pem"
    },
    {
        Name      = "*"
        CAFile    = "/etc/common-certs/ca-chain.cert.pem"
        KeyFile   = "/etc/common-certs/gateway.key.pem"
        CertFile  = "/etc/common-certs/gateway.cert.pem"
    },
    {
        name = "web"
        port = 8181
        connect {
            sidecar_service {
            proxy {
                mesh_gateway {
                    mode = "remote"
                }
                upstreams = [
                    {
                        destination_name = "api"
                        datacenter = "secondary"
                        local_bind_port = 10000
                    }
                ]
            }
            }
        }
    }
]