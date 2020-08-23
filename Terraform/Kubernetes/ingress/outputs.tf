data "kubernetes_ingress" "example" {
  metadata {
    name = "terraform-example"
  }
}

output "hostname" {
  value =[data.kubernetes_ingress.example.load_balancer_ingress.0.hostname
}
