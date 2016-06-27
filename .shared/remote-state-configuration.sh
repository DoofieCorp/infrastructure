#!/bin/bash

terraform remote config \
    -backend=azure \
    -backend-config="storage_account_name=${TF_VAR_name}${TF_VAR_env}${TF_VAR_location}" \
    -backend-config="key=${1}" \
    -backend-config="container_name=${TF_VAR_state_location}" \
    -backend-config="resource_group_name=${TF_VAR_name}_${TF_VAR_env}_${TF_VAR_location}"

