"tracing": {
  "http": {
     "name": "envoy.zipkin",
     "config": {
        "collector_cluster": "zipkin",
        "collector_endpoint": "/api/v1/spans",
        "shared_span_context": false
     }
  }
}
