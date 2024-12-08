#!/bin/bash

# Paths and Variables
TERRAFORM_OUTPUT_DIR="/mnt/c/DevOps-learning/Train-With-Shubham/Terraform-ansible-project/terraform"  # Replace with the actual Terraform directory path
ANSIBLE_INVENTORY_DIR="/mnt/c/DevOps-learning/Train-With-Shubham/Terraform-ansible-project/ansible/inventories"

# Navigate to the Terraform directory
cd "$TERRAFORM_OUTPUT_DIR" || { echo "Terraform directory not found"; exit 1; }

# Fetch IPs from Terraform outputs
DEV_IPS=$(terraform output -json dev_infra_instance_public_ips | jq -r '.[]')
STG_IPS=$(terraform output -json stg_infra_instance_public_ips | jq -r '.[]')
PROD_IPS=$(terraform output -json prod_infra_instance_public_ips | jq -r '.[]')

# Function to update inventory file
update_inventory_file() {
    local ips="$1"
    local inventory_file="$2"
    local env="$3"

    # Create or clear the inventory file
    > "$inventory_file"

    # Write the inventory header
    echo "[servers]" >> "$inventory_file"

    # Add dynamic hosts based on IPs
    local count=1
    for ip in $ips; do
        echo "server${count} ansible_host=$ip" >> "$inventory_file"
        count=$((count + 1))
    done

    # Add common variables
    echo "" >> "$inventory_file"
    echo "[servers:vars]" >> "$inventory_file"
    echo "ansible_user=ubuntu" >> "$inventory_file"
    echo "ansible_ssh_private_key_file=/home/amitabh/devops-key" >> "$inventory_file"
    echo "ansible_python_interpreter=/usr/bin/python3" >> "$inventory_file"

    echo "Updated $env inventory: $inventory_file"
}

# Update each inventory file
update_inventory_file "$DEV_IPS" "$ANSIBLE_INVENTORY_DIR/dev" "dev"
update_inventory_file "$STG_IPS" "$ANSIBLE_INVENTORY_DIR/stg" "stg"
update_inventory_file "$PROD_IPS" "$ANSIBLE_INVENTORY_DIR/prod" "prod"

echo "All inventory files updated successfully!"