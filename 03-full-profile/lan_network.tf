# Define the LAN Connectivity policy
resource "intersight_vnic_lan_connectivity_policy" "hv_lan_adapters" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed - eth0 and eth1 bound to MLOM ports 0 and 1"
    name = "hv_lan_adapters"
    target_platform = "Standalone"
    placement_mode = "custom"

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}

# Configure Default Ethernet adapter settings
resource "intersight_vnic_eth_adapter_policy" "default_ethernet" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "default_ethernet"

    interrupt_scaling = false
    advanced_filter = false

    vxlan_settings {
        enabled = false
    }

    roce_settings {
        enabled = false
    }

    nvgre_settings {
        enabled = false
    }

    arfs_settings {
        enabled = false
    }

    # Defaults
    uplink_failback_timeout = 5

    completion_queue_settings {
        nr_count = 5
        ring_size = 1
    }

    interrupt_settings {
        nr_count = 8
        coalescing_time = 125
        coalescing_type = "MIN"
        mode = "MSIx"
    }

    rss_settings = true

    rss_hash_settings {
        ipv4_hash = true
        ipv6_ext_hash = false
        ipv6_hash = true
        tcp_ipv4_hash = true
        tcp_ipv6_ext_hash = false
        tcp_ipv6_hash = true
        udp_ipv4_hash = false
        udp_ipv6_hash = false
    }

    rx_queue_settings {
        nr_count = 4
        ring_size = 512
    }

    tx_queue_settings{
        nr_count = 1
        ring_size = 256
    }

    tcp_offload_settings {
        large_receive = true
        large_send = true
        rx_checksum = true
        tx_checksum = true
    }
}

# Define Ethernet vNIC QoS Policy with MTU 1500
resource "intersight_vnic_eth_qos_policy" "default_qos_mtu_1500" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "default_qos_mtu_1500"
    mtu = 1500
    cos = 0
    rate_limit = 0
    priority = "Best Effort"
    trust_host_cos = false
}

# Define Ethernet vNIC network policy - trunks
resource "intersight_vnic_eth_network_policy" "eth_trunk_native_vlan_1" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "eth_trunk_native_vlan_1"
    target_platform = "Standalone"

    vlan_settings {
        default_vlan = 1
        mode = "TRUNK"
    }
}

# Define the LAN vNICs for server1 - MLOM eth0
resource "intersight_vnic_eth_if" "mlom_eth0" {
    name = "eth0"
    order = 0

    placement {
        id = "MLOM"
        pci_link = 0
        uplink = 0
    }

    cdn {
        nr_source = "user"
        value = "vic_mlom_eth0"
    }

    lan_connectivity_policy {
        moid = intersight_vnic_lan_connectivity_policy.hv_lan_adapters.moid
    }

    eth_adapter_policy {
        moid = intersight_vnic_eth_adapter_policy.default_ethernet.moid
    }

    eth_network_policy {
        moid = intersight_vnic_eth_network_policy.eth_trunk_native_vlan_1.moid
    }

    eth_qos_policy {
        moid = intersight_vnic_eth_qos_policy.default_qos_mtu_1500.moid
    }

    usnic_settings{
        nr_count = 0
        cos = 5
    }

    vmq_settings {
        enabled = false
        multi_queue_support = false
        num_interrupts = 16
        num_sub_vnics = 64
        num_vmqs = 4
    }
}

resource "intersight_vnic_eth_if" "mlom_eth1" {
    name = "eth1"
    order = 1

    placement {
        id = "MLOM"
        pci_link = 0
        uplink = 1
    }

    cdn {
        nr_source = "user"
        value = "vic_mlom_eth1"
    }

    lan_connectivity_policy {
        moid = intersight_vnic_lan_connectivity_policy.hv_lan_adapters.moid
    }

    eth_adapter_policy {
        moid = intersight_vnic_eth_adapter_policy.default_ethernet.moid
    }

    eth_network_policy {
        moid = intersight_vnic_eth_network_policy.eth_trunk_native_vlan_1.moid
    }

    eth_qos_policy {
        moid = intersight_vnic_eth_qos_policy.default_qos_mtu_1500.moid
    }

    usnic_settings{
        nr_count = 0
        cos = 5
    }

    vmq_settings {
        enabled = false
        multi_queue_support = false
        num_interrupts = 16
        num_sub_vnics = 64
        num_vmqs = 4
    }
}
