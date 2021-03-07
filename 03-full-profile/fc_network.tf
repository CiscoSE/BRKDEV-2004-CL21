# Define the SAN Connectivity policy
resource "intersight_vnic_san_connectivity_policy" "hv_san_adapters" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed - fc0 and fc1 bound to MLOM ports 0 and 1"
    name = "hv_san_adapters"
    target_platform = "Standalone"
    placement_mode = "custom"

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}

# Configure Default FC SAN adapter settings
resource "intersight_vnic_fc_adapter_policy" "default_fibre_channel" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "default_fibre_channel"

    error_recovery_settings {
        enabled = false
        # io_retry_count = 255
        # io_retry_timeout = 50
        # link_down_timeout = 240000
        # port_down_timeout = 240000
    }

    error_detection_timeout = 2000

    resource_allocation_timeout = 100000

    flogi_settings {
        retries = 8
        timeout = 4000
    }

    plogi_settings {
        retries = 8
        timeout = 20000
    }

    interrupt_settings {
        mode = "MSIx"
    }

    io_throttle_count = 256

    lun_count = 1024
    lun_queue_depth = 20

    rx_queue_settings {
        nr_count = 1
        ring_size = 64
    }

    tx_queue_settings {
        nr_count = 1
        ring_size = 64
    }

    scsi_queue_settings {
        nr_count = 1
        ring_size = 152
    }
}

# Define FC vNIC QoS Policy with Max Data Size of 2112
resource "intersight_vnic_fc_qos_policy" "default_qos_fc_size_2112" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "default_qos_fc_size_2112"

    rate_limit = 0
    max_data_field_size = 2112
    cos = 3
}

# Define FC vNIC network policy - for C-series standalone, declare no default_vlan
resource "intersight_vnic_fc_network_policy" "fc_no_default_vlan" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "fc_no_default_vlan"

    vsan_settings {
        default_vlan_id = 0
    }
}

# Define the SAN vNICs for server1 - MLOM fc0
resource "intersight_vnic_fc_if" "mlom_fc0" {
    name = "fc0"
    order = 4

    placement {
        id = "MLOM"
        pci_link = 0
        uplink = 0
    }

    type = "fc-initiator"
    persistent_bindings = true

    san_connectivity_policy {
        moid = intersight_vnic_san_connectivity_policy.hv_san_adapters.moid
    }

    fc_adapter_policy {
        moid = intersight_vnic_fc_adapter_policy.default_fibre_channel.moid
    }

    fc_network_policy {
        moid = intersight_vnic_fc_network_policy.fc_no_default_vlan.moid
    }

    fc_qos_policy {
        moid = intersight_vnic_fc_qos_policy.default_qos_fc_size_2112.moid
    }
}

# Define the SAN vNICs for server1 - MLOM fc1
resource "intersight_vnic_fc_if" "mlom_fc1" {
    name = "fc1"
    order = 5

    placement {
        id = "MLOM"
        pci_link = 0
        uplink = 1
    }

    type = "fc-initiator"
    persistent_bindings = true

    san_connectivity_policy {
        moid = intersight_vnic_san_connectivity_policy.hv_san_adapters.moid
    }

    fc_adapter_policy {
        moid = intersight_vnic_fc_adapter_policy.default_fibre_channel.moid
    }

    fc_network_policy {
        moid = intersight_vnic_fc_network_policy.fc_no_default_vlan.moid
    }

    fc_qos_policy {
        moid = intersight_vnic_fc_qos_policy.default_qos_fc_size_2112.moid
    }
}

# Define the SAN vNICs for server1 - MLOM fc2
resource "intersight_vnic_fc_if" "mlom_fc2" {
    name = "fc2"
    order = 6

    placement {
        id = "MLOM"
        pci_link = 0
        uplink = 0
    }

    type = "fc-initiator"
    persistent_bindings = true

    san_connectivity_policy {
        moid = intersight_vnic_san_connectivity_policy.hv_san_adapters.moid
    }

    fc_adapter_policy {
        moid = intersight_vnic_fc_adapter_policy.default_fibre_channel.moid
    }

    fc_network_policy {
        moid = intersight_vnic_fc_network_policy.fc_no_default_vlan.moid
    }

    fc_qos_policy {
        moid = intersight_vnic_fc_qos_policy.default_qos_fc_size_2112.moid
    }
}

# Define the SAN vNICs for server1 - MLOM fc3
resource "intersight_vnic_fc_if" "mlom_fc3" {
    name = "fc3"
    order = 7

    placement {
        id = "MLOM"
        pci_link = 0
        uplink = 1
    }

    type = "fc-initiator"
    persistent_bindings = true

    san_connectivity_policy {
        moid = intersight_vnic_san_connectivity_policy.hv_san_adapters.moid
    }

    fc_adapter_policy {
        moid = intersight_vnic_fc_adapter_policy.default_fibre_channel.moid
    }

    fc_network_policy {
        moid = intersight_vnic_fc_network_policy.fc_no_default_vlan.moid
    }

    fc_qos_policy {
        moid = intersight_vnic_fc_qos_policy.default_qos_fc_size_2112.moid
    }
}
