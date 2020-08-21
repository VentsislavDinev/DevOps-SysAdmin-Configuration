//create a sample dns  A record
resource "dns_a_record_set" "www" {
    //create zone for the current record
    zome = "vdinev.com"
    name = "www"
    address = [
        "10.0.0.0"
    ]
    ttl = 300
}

// create a sample DNS CNAME record 

resource "dns_cname_record_set" "test" {
    zone = var.zone
    name = var.name
    cname = var.cname
    ttl = 300 
}

