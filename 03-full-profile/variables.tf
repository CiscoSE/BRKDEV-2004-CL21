### As with everything Terraform, any missing values or default values
### can be overwritten with a CLI environment variable of the format:
###      TF_VAR_target_organization

###  devices.tf
variable "c240_m4l_lab_device_id" {
    description = "C240-M4L-Lab Service Serial Number"
    type = string
}

###  main.tf
variable "target_organization" {
    description = "Demo Organization for Deployments"
    type = string
    default = "Demo-Deployment"
}

###  general.tf
variable "local_ntp_servers" {
    description = "NTP Server - Terraform deployed"
    type = list
    default = [ 
        "0.us.pool.ntp.org",
        "1.us.pool.ntp.org",
        "2.us.pool.ntp.org"
    ]
}

variable "local_time_zone" {
    description = "Time Zone - Terraform deployed"
    type = string
    default = "America/New_York"
}

variable "ipv4_dns_server_1" {
    description = "IPv4 DNS Server - Terraform deployed"
    type = string
    default = "208.67.222.222"
}

variable "ipv4_dns_server_2" {
    description = "IPv4 DNS Server 2- Terraform deployed"
    type = string
    default = "208.67.220.220"
}
