# Start a container
resource "docker_container" "ubuntu" {
    name  = var.container_name
    image = "${docker_image.ubuntu.latest}"
    command = var.container_command,
    dns = var.container_dns
    # configuration that can be repeated to specify additional label name and value data to the container.
    labels {
        label = var.container_label
        value = var.container_label_value
    }
    #configuration that allows you to add or drop linux capabilities. 
    capabilities {
        add  = var.container_capabilities_add
        drop = var.container_capabilities_drop
    }
    #configuration that can be repeated to specify the extra mount mappings for the container. 
    mounts {
        target = var.container_mounts_target
        source = var.container_mounts_source
    }
    #configuration that can be repeated to specify the volumes attached to a container. 
    ports {
        internal = var.container_ports_internal
        external = var.container_ports_external
        ip = var.container_ports_ip
    }
    #configuration that can be repeated to specify the volumes attached to a container. 
    volumes {
        from_container = var.container_volumes_from_container
        host_path =  var.container_volumes_host_path
    }
    # configuration that can be repeated to specify advanced options for the container in a specific network
    networks_advanced  {
        name = var.container_networks_advanced_name
        ipv4_address = var.container_networks_ipv4_address
    }
    # configuration that can be repeated to specify the devices exposed to a container. 
    devices  {
        host_path  = var.container_devices_host_path
    }
    #can be repeated to specify the extra ulimits for the container.
    ulimit  {
        name =  var.container_ulimit_name
        soft = var.container_ulimit_soft
    }
    #The healthcheck block is a test to perform to check that the container is healthy. 
    healthcheck  {
       test = var.container_healthcheck
    }
}


# Find the latest Ubuntu precise image.
resource "docker_image" "ubuntu" {
  name = var.docker_image
}