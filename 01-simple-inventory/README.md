# Simple inventory and organization creation

This particular workspace of Terraform (open source) configuration files
will serve as a basic environment in which to get familiar with the
Intersight provider and to test your API credentials.  You will be able
to do the following actions with the provided Terraform:

- Assign the "default" organization to Terraform data source
- Assign a given C-series server, found by serial number to a data source
- Create a new Intersight organization

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

## Usage

You'll instruct Terraform to prepare the environment and download the Intersight
provider via:

```bash
terraform init
```

To determine what work that Terraform will perform based on your current state
(none, at first run), you'll run the plan:

```bash
terraform plan
```

Apply your Terraform to create the infrastructure you've specified via:

```bash
terraform apply
```

With your simply infrastructure deploy - one new Intersight organization and two data
sources for existing Intersight object - you can inspect the current state via:

```bash
terraform show
```

This output gives you insight on the data sources what information is available
for reference throughout your Terraform configuration

## Example output

Initialization

```bash
% terraform init

Initializing the backend...

Initializing provider plugins...
- Finding ciscodevnet/intersight versions matching "1.0.1"...
- Installing ciscodevnet/intersight v1.0.1...
- Installed ciscodevnet/intersight v1.0.1 (signed by a HashiCorp partner, key ID 7FA19DB0A5A44572)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Plan

```bash
% terraform plan

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # intersight_organization_organization.target will be created
  + resource "intersight_organization_organization" "target" {
      + account         = (known after apply)
      + class_id        = (known after apply)
      + description     = "Terraform Deployed"
      + id              = (known after apply)
      + moid            = (known after apply)
      + name            = "Demo-Deployment"
      + object_type     = (known after apply)
      + resource_groups = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

Apply

```bash
% terraform apply --auto-approve
intersight_organization_organization.target: Creating...
intersight_organization_organization.target: Creation complete after 1s [id=6046648e6972652d32c78ff9]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

Show (note: output excerpted and redacted here for privacy reasons)

```bash
% terraform show       
# data.intersight_compute_rack_unit.C240-M4L-Lab:
data "intersight_compute_rack_unit" "C240-M4L-Lab" {
    additional_properties   = jsonencode(
        {
            CreateTime          = "2021-02-18T22:27:08.674Z"
            Dn                  = "sys/rack-unit-1"
            ModTime             = "2021-03-08T09:53:26.134Z"
            Model               = "UCSC-C240-M4L"
            Revision            = ""
            Rn                  = ""
            Serial              = "<redacted>"
            SharedScope         = ""
            Tags                = [
                {
                    Key   = "Intersight.LicenseTier"
                    Value = "Premier"
                },
            ]
            Vendor              = "Cisco Systems Inc"
        }
    )
    admin_power_state       = "policy"
    available_memory        = 131072
    bios_post_complete      = false
    class_id                = "compute.RackUnit"
    dn                      = "sys/rack-unit-1"
    fault_summary           = 0
    management_mode         = "IntersightStandalone"
    memory_speed            = "1866"
    mgmt_ip_address         = "10.60.180.170"
    model                   = "UCSC-C240-M4L"
    num_adaptors            = 4
    num_cpu_cores           = 16
    num_cpu_cores_enabled   = 16
    num_cpus                = 2
    num_eth_host_interfaces = 4
    num_fc_host_interfaces  = 4
    num_threads             = 32
    object_type             = "compute.RackUnit"
    oper_power_state        = "on"
    oper_reason             = []
    platform_type           = "IMC"
    presence                = "equipped"
    server_id               = 1
    total_memory            = 131072
    user_label              = "UCS C240ML Standalone"
    vendor                  = "Cisco Systems Inc"

    adapters {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "adapter.Unit"
    }

    bios_bootmode {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "bios.BootMode"
    }

    biosunits {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "bios.Unit"
    }

    bmc {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "management.Controller"
    }

    board {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "compute.Board"
    }

    fanmodules {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "equipment.FanModule"
    }
    kvm_ip_addresses {
        address         = "10.60.180.170"
        category        = "Equipment"
        class_id        = "compute.IpAddress"
        default_gateway = "10.60.180.1"
        dn              = "sys/rack-unit-1/mgmt/if-1"
        http_port       = 80
        https_port      = 443
        kvm_port        = 2068
        kvm_vlan        = 1
        name            = "Outband"
        object_type     = "compute.IpAddress"
        subnet          = "255.255.255.0"
        type            = "MgmtInterface"
    }

    pci_devices {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "pci.Device"
    }
    psus {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "equipment.Psu"
    }
    psus {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "equipment.Psu"
    }

    registered_device {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "asset.DeviceRegistration"
    }

    sas_expanders {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "storage.SasExpander"
    }

    tags {
        key   = "Intersight.LicenseTier"
        value = "Premier"
    }
}

# data.intersight_organization_organization.default:
data "intersight_organization_organization" "default" {
    class_id    = "organization.Organization"
    description = "User in a Default Organization automatically has access to all the resources available for the User Account. If required, a User with Account Administrator privileges can remove resources from the default organization."
    id          = "<redacted>"
    moid        = "<redacted>"
    name        = "default"
    object_type = "organization.Organization"

    account {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "iam.Account"
    }

    resource_groups {
        class_id    = "mo.MoRef"
        moid        = "<redacted>"
        object_type = "resource.Group"
    }
}

# intersight_organization_organization.target:
resource "intersight_organization_organization" "target" {
    account         = [
        {
            additional_properties = ""
            class_id              = "mo.MoRef"
            moid                  = "<redacted>"
            object_type           = "iam.Account"
            selector              = ""
        },
    ]
    class_id        = "organization.Organization"
    description     = "Terraform Deployed"
    id              = "<redacted>"
    moid            = "<redacted>"
    name            = "Demo-Deployment"
    object_type     = "organization.Organization"
    resource_groups = []
}
```
