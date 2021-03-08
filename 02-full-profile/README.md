# Comprehensive Server Profile for Standalone C-series servers

This particular workspace of Terraform (open source) configuration files
will build on the entry level activities in
[01-simple-inventory](../01-simple-inventory/README.md)
and help you build a comprehensive set of UCS server related policies that
will then be bound to a server profile which, at your convenience, can be
manually deployed to C-series server in your environment and Intersight
account.

## Pre-requisites

As specified in the top level [README](../README.md), you'll need to set up
some basic Intersight infrastructure in order to leverage this Terraform repo:

- [Create Intersight Account](https://intersight.com/help/getting_started#create_a_cisco_intersight_account)
- [Create API Keys](https://intersight.com/help/features#api_keys)
- [Claim Server in Intersight](https://intersight.com/help/getting_started#target_claim)

## Setup

Once the API keys have been identified, you'll need to define the following environment
variables with the indicated content:

- **TF_VARS_intersight_apikey**: The API key with administrative access to the Intersight account
- **TF_VARS_intersight_secretkey**: The Secret keyfile *contents* for the provided API key
- **TF_VARS_c240_m4l_lab_device_id**: The serial number for the C-series server being used in this demo

You'll also need to define these SNMP related security credentials:

- **TF_VAR_snmp_access_community_string**: SNMP v1/v2c community string
- **TF_VAR_snmp_trap_community_string**: SNMP v1/v2c trap community string

Most of the parameters within the Terraform configuration files are "hard coded" (as explained
in the top level README) but there are **end user specific** variables that are built into this
Terraform workspace that **must** be customized to your environment.  Those variables can be
found in **variables.tf** and cover information such as:

- NTP servers and time zone
- DNS servers
- SMTP sender, receiver, and server
- SNMP site local information

## Usage

Important note:  For the purposes of this session and repository, the Terraform
configuration files will only create all the policies and bind them to the
server profile. The "deploy" action of the server profile resource that
programs the physical hardware is intended to be done manually in the
Intersight interface. This is done primarily for educational reasons as:

1. The deploy action can take up to 15 minutes
1. Any errors in the deploy are best seen (at this time) in the GUI

### Init

You'll instruct Terraform to prepare the environment and download the Intersight
provider via:

```bash
terraform init
```

### Plan 

To determine what work that Terraform will perform based on your current state
(none, at first run), you'll run the plan:

```bash
terraform plan
```

### Apply

Apply your Terraform to create the infrastructure you've specified via:

```bash
terraform apply
```

### Show

With your simply infrastructure deploy - one new Intersight organization and two data
sources for existing Intersight object - you can inspect the current state via:

```bash
terraform show
```

