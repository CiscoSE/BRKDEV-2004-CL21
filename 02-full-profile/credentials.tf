# https://intersight.com/an/settings/api-keys/
## Generate API key to obtain the API Key and PEM file

# APIKEY string required to be provided in a secure method
variable "intersight_apikey" {
    description = "API Key for Terraform Demo Account"
    type = string
    sensitive = true
}

## Two options exist for specifying the secret key.

### Option 1 is to provide PEM filename that is stored on disk
### Note: operationally, this is challenging approach but works well.
# variable "intersight_secretkeyfile" {
#     description = "Filename (PEM) that provides secret key for Terraform Demo Account"
#     type = string
#     sensitive = true
# }

### Option 2: Provide entire contents of PEM file as a string
variable "intersight_secretkey" {
    description = "Contents of secret key PEM file"
    type = string
    sensitive = true
}

variable "intersight_endpoint" {
    description = "Intersight API endpoint"
    type = string
    default = "https://intersight.com"
}

# SNMP Credentials
variable "snmp_access_community_string" {
    description = "SNMP v1/v2c community string"
    type = string
    sensitive = true
}

variable "snmp_trap_community_string" {
    description = "SNMP v1/v2c trap community string"
    type = string
    sensitive = true
}

# In standard Terraform operations, you'll need to provide these values via
# environment variables (TF_VAR_intersight_secretkey and TF_VAR_intersight_apikey),
# Terraform Cloud, Hashicorp Vault, provide them when prompted at the command line,
# or fill them in above (but secure these files and don't mistakenly commit them to
# your repo!!)
