# Create the Server Profile
resource "intersight_server_profile" "srvprof_server1" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "SrvProf-Server1"
    action = "No-op"

    assigned_server {
        object_type = "compute.RackUnit"
        moid = data.intersight_compute_rack_unit.c240_m4l_lab.moid
    }

}

# Configure Boot Order ("boot precision") policy
resource "intersight_boot_precision_policy" "boot_order_vdvd_local_hdd" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed - Boot vDVD and local HDD"
    name = "local_boot_order"
    configured_boot_mode = "Legacy"
    enforce_uefi_secure_boot = false

    # boot_devices examples found here:
    #   https://github.com/CiscoDevNet/terraform-provider-intersight/blob/master/examples/server_configurations/boot_precision_policy.tf
    # object_type found here:
    #   https://intersight.com/apidocs/apirefs/boot/PrecisionPolicies/model/
    boot_devices {
        name = "RemoteDVD"
        enabled = true
        object_type = "boot.VirtualMedia"
        class_id = "boot.VirtualMedia"
        additional_properties = jsonencode({
            Subtype = "kvm-mapped-dvd"
        })
    }

    # /api/v1/boot/PrecisionPolicies/{Moid} to get existing policy values
    boot_devices {
        name = "LocalHDD"
        enabled = true
        object_type = "boot.LocalDisk"
        additional_properties = jsonencode({
            Slot = "HBA"
        })
    }

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}

# Configure BIOS policy
resource "intersight_bios_policy" "hv_type1_bios" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "hv_type1_bios"

    # NIC settings
    cdn_enable = "enabled"
    cdn_support = "enabled"
    lom_ports_all_state = "enabled"
    lom_port0state = "Legacy Only"
    lom_port1state = "Legacy Only"
    lom_port2state = "Legacy Only"
    lom_port3state = "Legacy Only"
    onboard10gbit_lom = "enabled"
    onboard_gbit_lom = "enabled"
    pci_option_ro_ms = "enabled"

    # Memory settings
    numa_optimized = "enabled"
    direct_cache_access = "enabled"

    # CPU Settings
    cpu_energy_performance = "balanced-performance"
    cpu_power_management = "energy-efficient"
    cpu_performance = "custom"

    # Intel/Virtualization Settings
    enhanced_intel_speed_step_tech = "enabled"
    execute_disable_bit = "enabled"
    intel_hyper_threading_tech = "enabled"
    intel_speed_select = "Base"
    intel_virtualization_technology = "enabled"
    intel_vt_for_directed_io = "enabled"
    intel_vtd_coherency_support = "enabled"
    intel_vtd_pass_through_dma_support = "enabled"
    llc_prefetch = "disabled"
    processor_c1e = "enabled"
    processor_c3report = "enabled"
    processor_c6report = "enabled"
    processor_cstate = "enabled"
    pstate_coord_type = "HW ALL"
    sr_iov = "enabled"

    # Miscellaneous
    serial_port_aenable = "enabled"
    snc = "disabled"

    # Required to permit idempotency
    memory_size_limit = "platform-default"
    partial_mirror_percent = "platform-default"
    partial_mirror_value1 = "platform-default"
    partial_mirror_value2 = "platform-default"
    partial_mirror_value3 = "platform-default"
    partial_mirror_value4 = "platform-default"
    patrol_scrub_duration = "platform-default"

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}

# Define Adapter Configuration policy for a server - Ethernet and FCoE enabled MLOM
resource "intersight_adapter_config_policy" "hv_mlom_eth_fc" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed - MLOM Configuration for CE setup"
    name = "hv_mlom_eth_fc"

    # First Adapter
    settings {
        slot_id = "MLOM"

        # Ethernet Settings
        eth_settings {
            lldp_enabled = true
        }

        # FC Settings
        fc_settings {
            fip_enabled = true
        }

        # PC Settings
        port_channel_settings {
            enabled = false
        }

        # Default DCE settings
        dce_interface_settings {
            fec_mode = "Off"
            interface_id = 0
        }
        dce_interface_settings {
            fec_mode = "Off"
            interface_id = 1
        }
        dce_interface_settings {
            fec_mode = "Off"
            interface_id = 2
        }
        dce_interface_settings {
            fec_mode = "Off"
            interface_id = 3
        }
    }

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}
