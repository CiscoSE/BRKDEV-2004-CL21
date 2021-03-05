### As with everything Terraform, any missing values or default values
### can be overwritten with a CLI environment variable of the format:
###      TF_VAR_target_organization

variable "c240_m4l_lab_device_id" {
    description = "C240-M4L-Lab Service Serial Number"
    type = string
}

variable "target_organization" {
    description = "Demo Organization for Deployments"
    type = string
    default = "Demo-Deployment"
}
