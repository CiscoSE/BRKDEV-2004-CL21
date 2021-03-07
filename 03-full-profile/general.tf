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

# Enable SMTP service
resource "intersight_smtp_policy" "enable_smtp_client" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "enable_smtp_client"
    enabled = true

    min_severity = "major"
    smtp_port = 25

    sender_email = var.smtp_sender_email
    smtp_server = var.smtp_outgoing_server
    smtp_recipients = var.smtp_recipients_email

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}

# Disable SMTP service
resource "intersight_smtp_policy" "disable_smtp_client" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "disable_smtp_client"
    enabled = false
}

# Enable SNMP service
resource "intersight_snmp_policy" "enable_snmp_client" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "enable_snmp_client"
    enabled = true

    access_community_string = var.snmp_access_community_string
    community_access        = var.snmp_community_access
    trap_community          = var.snmp_trap_community_string
    sys_contact             = var.snmp_sys_contact
    sys_location            = var.snmp_sys_location
    engine_id               = var.snmp_unique_engine_id

    snmp_traps {
        destination = var.snmp_trap_destination
        enabled     = true
        type        = "Trap"
        nr_version  = "V2"
    }

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}

# Disable SNMP service
resource "intersight_snmp_policy" "disable_snmp_client" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "disable_snmp_client"
    enabled = false
}

# Configure SYSLOG settings, local only
resource "intersight_syslog_policy" "syslog_local_only_notice" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "syslog_local_only_notice"

    local_clients = [ {
      additional_properties = ""
      class_id = "syslog.LocalFileLoggingClient"
      min_severity = "notice"
      object_type = "syslog.LocalFileLoggingClient"
    } ]

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}
