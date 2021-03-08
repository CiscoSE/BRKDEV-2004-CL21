terraform {
    required_version = "~> 0.14"
    required_providers {
        intersight = {
            source = "CiscoDevNet/intersight"
            version = "1.0.1"
        }
    }
}

provider "intersight" {
    apikey = var.intersight_apikey
    secretkey = var.intersight_secretkey
    endpoint = var.intersight_endpoint
}

## Get the MO data for the default organization in the account.
# /api/v1/organization/Organizations$filter=(Name eq 'default')
data "intersight_organization_organization" "default" {
    name = "default"
}

## Create a new organization resource for this demo
resource "intersight_organization_organization" "target" {
    description = "Terraform Deployed"
    name = var.target_organization
}
