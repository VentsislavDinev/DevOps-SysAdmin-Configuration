resource "kubernetes_secret" "example" {
    metadata {
        name = "${var.secret_metadata_name}"
        annotations = {
            "kubernetes.io/service-account.name" = var.secret_metadata_account
        }
    }

    #data = {
    #  username = "admin"
    #  password = "P4ssw0rd"
    #}
    data = {
        ".dockerconfigjson" = var.secret_data_docker_file
    }
    type = "${var.secret_type}"
}