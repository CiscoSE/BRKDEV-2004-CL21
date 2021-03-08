# Automating UCS Server Provisioning with Terraform and Intersight

## Use Case Statement

The workspace [01-simple-inventory](./01-simple-inventory/README.md) provides a very minimal
Terraform configuration to simply help you get your core credentials defined, tested, and
also give you some sample Terraform commands and output to help navigate your first time
with Terraform and Intersight.

The workspace [02-full-profile](./02-full-profile/README.md) provides a comprehensive set
of server policies and server profile sufficient to configure a UCS C-series rack mount
server (in standalone management mode) that is connected to Intersight as a hypervisor with
ethernet, fibre channel, and local storage resources.

## Pre-requisites

- [Create Intersight Account](https://intersight.com/help/getting_started#create_a_cisco_intersight_account)
- [Create API Keys](https://intersight.com/help/features#api_keys)
- [Claim Server in Intersight](https://intersight.com/help/getting_started#target_claim)
- [Terraform](https://www.terraform.io/downloads.html)
- Cisco UCS C-series Standalone rack mount server

## Clone the Repository and Deploy the Profiles

```bash
git clone https://github.com/CiscoSE/BRKDEV-2004-CL21
cd BRKDEV-2004-CL21

# For use case 1 (see README for details)
cd 01-simple-inventory
terraform init
terraform plan
terraform apply
cd ..

# For use case 2 (see README for details, variables are needed!)
cd 02-full-profile
terraform init
terraform plan
terraform apply
cd ..
```

## Required Variables

The following environment variables are required to be set for all Terraform plans in this
repository:

- **TF_VARS_intersight_apikey**: The API key with administrative access to the Intersight account
- **TF_VARS_intersight_secretkey**: The Secret keyfile *contents* for the provided API key
- **TF_VARS_c240_m4l_lab_device_id**: The serial number for the C-series server being used in this demo

For the full profile Terraform plan [02-full-profile/main.tf](./02-full-profile/main.tf), you'll
also need to define these SNMP related security credentials:

- **TF_VAR_snmp_access_community_string**: SNMP v1/v2c community string
- **TF_VAR_snmp_trap_community_string**: SNMP v1/v2c trap community string

Please refer to the [setup-environment-vars.txt](./setup-environment-vars.txt) file to show a 
"safe" method for storing the credentials in your local acount - "safe", of course, in this case
with regards to avoiding accidental commits of your credentials to the Git repository.

