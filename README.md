# BRKDEV-2004-CL21
Cisco Live 2021 Anytime Breakout Session BRKDEV-2004

This repository pairs with the aforementioned session - the guiding principle for this example
repository is to provide a working, usable set of Terraform configuration files.  While some
best practices may suggest a more frequent use of variables throughout the plan, (a) that approach
would reduce the educational value and (b) many of these "hard coded" values derive from existing
best practice parameters within the UCS ecosystem.  Of course, they should be adjusted based on
your application needs but - with any luck - most will not need to be changed.

There are some organization specific variables that were built into this Terraform configuration.
Those variables and their defaults are defined in the **variables.tf** file of each subdirectory.
You should **absolutely** changed those to match your organization.

## Pre-requisites

- [Create Intersight Account](https://intersight.com/help/getting_started#create_a_cisco_intersight_account)
- [Create API Keys](https://intersight.com/help/features#api_keys)
- [Claim Server in Intersight](https://intersight.com/help/getting_started#target_claim)
- [Terraform](https://www.terraform.io/downloads.html)
- Cisco UCS C-series Standalone rack mount server, in order to actually deploy the server profile.

## Required Variables

The following environment variables are required to be set for all Terraform
plans in this repository:

- **TF_VARS_intersight_apikey**: The API key with administrative access to the Intersight account
- **TF_VARS_intersight_secretkey**: The Secret keyfile *contents* for the provided API key
- **TF_VARS_c240_m4l_lab_device_id**: The serial number for the C-series server being used in this demo

For the full profile Terraform plan [02-full-profile/main.tf](./02-full-profile/main.tf), you'll
also need to define these SNMP related security credentials:

- **TF_VAR_snmp_access_community_string**: SNMP v1/v2c community string
- **TF_VAR_snmp_trap_community_string**: SNMP v1/v2c trap community string

Please refer to the [setup-environment-vars.txt](./setup-environment-vars.txt) file to show a "safe" method for storing the
credentials in your local acount - "safe", of course, in this case with regards to avoiding accidental
commits of your credentials to the Git repository.

## How to use this repository

After satisfying the pre-requisites, customizing the **variables.tf** values, and defining the needed
environment variables, the Terraform plan is deployed in the usual way:

1. terraform init
1. terraform plan
1. terraform apply

For the purposes of this session and repository, the Terraform configuration files will only create
all the policies and bind them to the server profile. The "deploy" action of the server profile resource
is intended to be done manually in the Intersight interface.
