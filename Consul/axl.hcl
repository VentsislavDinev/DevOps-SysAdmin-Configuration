namespace "foo" {
    # Allow the service and its sidecar proxy to register into the catalog.
    service "<Service Name>" {
        policy = "write"
    }

    service "<Service Name>-sidecar-proxy" {
        policy = "write"
    }

    agent_prefix "" {
    policy = "read"
    }

    agent "TestAgent" {
    policy = "write"
    }

    # Allow for any potential upstreams to be resolved.
    service_prefix "" {
        policy = "read"
    }

    node_prefix "" {
        policy = "read"
    }

    event_prefix "" {
    policy = "read"
    }

    event "deploy" {
    policy = "write"
    }

    key_prefix "_rexec" {
    policy = "write"
    }

    query_prefix "" {
    policy = "read"
    }

    query "foo" {
    policy = "write"
    }

    session_prefix "" {
    policy = "read"
    }

    session "app" {
    policy = "write"
    }

    session "admin" {
    policy = "deny"
    }

    # This controls access to cluster-wide Consul operator information.
    operator = "read"
}