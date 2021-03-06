# Enable SSH policy
resource "intersight_ssh_policy" "enable_ssh" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "enable_ssh"
    enabled = true
    port = 22
    timeout = 1800

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}

# Disable SSH policy
resource "intersight_ssh_policy" "disable_ssh" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "disable_ssh"
    enabled = false
}

# Enable IP KVM policy
resource "intersight_kvm_policy" "enable_ip_kvm" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "enable_ip_kvm"
    enabled = true
    enable_local_server_video = true
    enable_video_encryption = false
    remote_port = 2068
    maximum_sessions = 4

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}

# Disable IP KVM policy
resource "intersight_kvm_policy" "disable_ip_kvm" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "disable_ip_kvm"
    enabled = false
}

# Configure NTP policy
resource "intersight_ntp_policy" "enable_ntp" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "enable_ntp"
    enabled = true
    ntp_servers = var.local_ntp_servers
    timezone = var.local_time_zone

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}

resource "intersight_ntp_policy" "disable_ntp" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "disable_ntp"
    enabled = false

}

# Configure DNS ("Network Connectivity") policy
resource "intersight_networkconfig_policy" "local_dns_server" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "local_dns_server"
    preferred_ipv4dns_server = var.ipv4_dns_server_1
    alternate_ipv4dns_server = var.ipv4_dns_server_2
    enable_ipv6 = false
    enable_ipv6dns_from_dhcp = false
    enable_dynamic_dns = false

    # GitHub Issue #15: https://github.com/CiscoDevNet/terraform-provider-intersight/issues/15
    # Must comment out on initial creation, then uncomment on
    # subsequent 'terraform apply' to prevent updates.

    # preferred_ipv6dns_server = "::"
    # alternate_ipv6dns_server = "::"


    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}
