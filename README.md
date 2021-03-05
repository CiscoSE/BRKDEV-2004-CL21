# BRKDEV-2004-CL21
Cisco Live 2021 Anytime Breakout Session BRKDEV-2004

## Required Variables

The following environment variables are required to be set for all Terraform
plans in this repository:

- **TF_VARS_c240_m4l_lab_device_id**: The serial number for the C-series server being used in this demo
- **TF_VARS_intersight_apikey**: The API key with administrative access to the Intersight account
- **TF_VARS_intersight_secretkey**: The Secret keyfile *contents* for the provided API key

Please refer to the (./setup-environment-vars.txt) file to show a "safe" method for storing the
credentials in your local acount - "safe", of course, in this case with regards to avoiding accidental
commits of your credentials to the Git repository.
