#!/bin/bash

DISK_DIR="./test/disk_images"

# Ensuring the VM directory exists
mkdir -p "$DISK_DIR"

# Function to create a VM
create_vm() {
    echo "Creating VM..."
    
    # Create a virtual disk if it doesn't exist
    DISK_IMAGE="$DISK_DIR/$1.qcow2"
    if [ ! -f "$DISK_IMAGE" ]; then
        echo "Creating disk image $DISK_IMAGE..."
        qemu-img create -f qcow2 "$DISK_IMAGE" ${4}G
    else
        echo "Disk image $DISK_IMAGE already exists."
    fi
    
    # Start the VM with the ISO
    echo "Starting VM with ISO $2..."
    qemu-system-x86_64 \
        -m "$3" \
        -cdrom "$2" \
        -hda "$DISK_IMAGE" \
        -boot d \
        -net nic \
        -net user \
        -nographic \
        -name "$1"
}

# Function to start an existing VM
start_vm() {
    echo "Starting existing VM..."
    
    DISK_IMAGE="$DISK_DIR/$VM_NAME.qcow2"
    if [ -f "$DISK_IMAGE" ]; then
        qemu-system-x86_64 \
            -m "$RAM_SIZE" \
            -hda "$DISK_IMAGE" \
            -net nic \
            -net user \
            -nographic \
            -name "$VM_NAME"
    else
        echo "Disk image $DISK_IMAGE does not exist."
    fi
}

# Function to remove a VM
remove_vm() {
    echo "Removing VM..."
    
    DISK_IMAGE="$DISK_DIR/$VM_NAME.qcow2"
    # Remove the virtual disk
    if [ -f "$DISK_IMAGE" ]; then
        echo "Removing disk image $DISK_IMAGE..."
        rm -f "$DISK_IMAGE"
    else
        echo "Disk image $DISK_IMAGE does not exist."
    fi
    
    echo "VM removed."
}

# Function to list all VMs
list_vms() {
    echo "Listing all VMs..."
    
    if [ -d "$DISK_DIR" ]; then
        ls "$DISK_DIR"/*.qcow2 2>/dev/null | while read -r vm; do
            vm_name=$(basename "$vm" .qcow2)
            echo "VM: $vm_name"
        done
    else
        echo "No VMs found."
    fi
}