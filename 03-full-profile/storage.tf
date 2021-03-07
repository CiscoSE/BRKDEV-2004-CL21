# Define the Disk Group policy (generic to C240 M4L servers with 12 drives)
resource "intersight_storage_disk_group_policy" "c240_m4l_raid6_all_drives" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "c240_m4l_raid6_all_drives"
    raid_level = "Raid6"
    use_jbods = true

    span_groups {
        disks {
            slot_number = 1
        }
        disks {
            slot_number = 2
        }
        disks {
            slot_number = 3
        }
        disks {
            slot_number = 4
        }
        disks {
            slot_number = 5
        }
        disks {
            slot_number = 6
        }
        disks {
            slot_number = 7
        }
        disks {
            slot_number = 8
        }
        disks {
            slot_number = 9
        }
        disks {
            slot_number = 10
        }
        disks {
            slot_number = 11
        }
        disks {
            slot_number = 12
        }
    }
}

# Define the storage policy: Using a RAID6 of all 12 C240-M4L, create a single virtual drive
resource "intersight_storage_storage_policy" "c240_m4l_local_raid6_one_virtual_drive" {
    organization {
        moid = data.intersight_organization_organization.default.moid
    }

    description = "Terraform deployed"
    name = "c240_m4l_local_raid6_one_virtual_drive"
    retain_policy_virtual_drives = true
    unused_disks_state = "UnconfiguredGood"

    virtual_drives {
        name = "LOCAL_RAID6"
        disk_group_policy = intersight_storage_disk_group_policy.c240_m4l_raid6_all_drives.moid
        size = 0
        expand_to_available = true
        boot_drive = true
        access_policy = "ReadWrite"
        drive_cache = "Enable"
        io_policy = "Default"
        strip_size = "Default"
        read_policy = "Default"
        write_policy = "Default"
    }

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.srvprof_server1.moid
    }
}
