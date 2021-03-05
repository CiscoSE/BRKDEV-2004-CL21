# For pre-claimed devices in Intersight, you'll need to create a data
# source in order to reference it in the remaining Terraform configuration
data "intersight_compute_rack_unit" "C240-M4L-Lab" {
    serial = var.c240_m4l_lab_device_id
}

# Ideally, you'll create the device registration (or import it) via a
# resource directly.  This resource does not yet exist but has been
# submitted as an issue (#48)
##
# resource "intersight_asset_device_claim" "C240-M4L-Lab" {
#     serial_number = var.c240_m4l_lab_device_id
#     target_type = var.c240_m4l_lab_claim_code
# }
