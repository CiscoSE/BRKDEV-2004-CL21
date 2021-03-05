terraform {
    required_version = "~> 0.14"
    required_providers {
        intersight = {
            source = "CiscoDevNet/intersight"
            version = "1.0.0"
        }
    }
}

provider "intersight" {
    apikey = var.intersight_apikey
    secretkey = var.intersight_secretkey
    endpoint = var.intersight_endpoint
}
