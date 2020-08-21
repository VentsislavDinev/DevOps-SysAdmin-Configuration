
// get a sample A record report
data "dns_a_record_set" "facebook" {
    host = "facebook.com"
}

// render sample A record report
output "facebook_address" {
    value = "${join(",", data.dns_a_record_set.facebook.addrs)}"
    description = "facebook.com dns a records."
    sensitive   = false
}

//  get sample CNAME record report
data "dns_cname_record_set" "facebook" {
    host = "facebook.com"
}

// render sample CNAME record report 
#output "facebook_cname" {
   # value = "${join(",", data.dns_cname_record_set.facebook.cname")}"
#}

