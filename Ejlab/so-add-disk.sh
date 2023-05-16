#! /bin/bash

NETINVM_DIR=$HOME/netinvm
DISKS_DIR=$NETINVM_DIR/libvirt/images-so

#
# Create qcow2 disk
# Usage: 
#     disk_create disk_name disk_size
#
disk_create()
{
    # Process arguments
    [[ $# -eq 2 ]] || {
        echo "disk_create: wrong argument count: $# (must be 2)"
        return 1
    }
    disk_name="$1"; shift
    disk_size="$1"; shift
    
    # Check infraestructure
    [[ -e "$disk_name" ]] && {
        echo "disk_create: disk already exists: $disk_name"
        return 1
    }
    
    # Disk creation
    qemu-img create -f qcow2 $disk_name $disk_size
    return $?
}

#
# Attach existing disk to domain
# Usage: 
#     disk_attach domain target disk_name
#
disk_attach()
{
    # Process arguments
    [[ $# -eq 3 ]] || {
        echo "disk_attach: wrong argument count: $# (must be 3)"
        return 1
    }
    domain="$1"; shift
    target="$1"; shift
    disk_name="$1"; shift
    
    # Check infraestructure
    [[ -f "$disk_name" ]] || {
        echo "disk_attach: disk doesn't exist: $disk_name"
        return 1
    }

    # Attach disk to domain
    virsh attach-disk "$domain" "$disk_name" "$target" --subdriver qcow2 --persistent
}


#
# Main program
#

# Process arguments
[[ $# -eq 3 ]] || {
    echo "Usage: $(basename $0) domain target size"
    exit 1
}
domain="$1"; shift
target="$1"; shift
size="$1"; shift
echo -e "---\nDomain: $domain, target: $target, size: $size"

# Create disk directory if necessary
[[ -d "$DISKS_DIR" ]] || {
    echo "Creating directory: $DISKS_DIR"
    mkdir "$DISKS_DIR" || exit 1
}

# Check that domain is shut off
[[ "$(virsh domstate $domain)"  == "shut off" ]] || {
    echo "Domain "$domain" must be shut off."
    exit 1
}

# Create disk and attach it to a domain
disk="$DISKS_DIR/$domain-$target.qcow2"
disk_create "$disk" $size
disk_attach "$domain" "$target" "$disk"
