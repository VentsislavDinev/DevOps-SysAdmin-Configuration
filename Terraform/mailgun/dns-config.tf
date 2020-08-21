provider "dns" {
  #version = "2.2.0"
}

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
    zone = "vdinev.com"
    name = "test"
    cname = "bar.example.com"
    ttl = 300 
}

// get a sample A record report
data "dns_a_record_set" "facebook" {
    host = "facebook.com"
}

// render sample A record report
output "facebook_address" {
  value = "${join(",", data.dns_a_record_set.facebook.addrs)}"
}

//  get sample CNAME record report
data "dns_cname_record_set" "facebook" {
    host = "facebook.com"
}

// render sample CNAME record report 
#output "facebook_cname" {
   # value = "${join(",", data.dns_cname_record_set.facebook.cname")}"
#}

