#! /bin/bash

NETINVM_DIR=$HOME/netinvm
DISKS_DIR=$NETINVM_DIR/libvirt/images-so

#
# Detach all DISKS_DIR disks from domain and delete them from disk
# Usage: 
#     domain_delete_disks domain
#
domain_delete_disks()
{
    # Process arguments
    [[ $# -eq 1 ]] || {
        echo "domain_delete_disks: wrong argument count: $# (must be 1)"
        return 1
    }
    domain="$1"; shift
    
    # Detach SO disks from domain and delete them from disk
    virsh domblklist "$domain" | grep "$DISKS_DIR" |
        while read target disk
        do
            echo "domain: $domain, target: $target, disk: $disk"
            virsh detach-disk "$domain" "$target" --config
            rm -f "$disk"
        done
}


#
# Main program
#

# Process arguments
[[ $# -eq 1 ]] || {
    echo "Usage: $(basename $0) domain"
    exit 1
}
domain="$1"; shift

# Check that domain is shut off
[[ "$(virsh domstate extb)"  == "shut off" ]] || {
    echo "Domain "$domain" must be shut off."
    exit 1
}

# Remove disks from domain
echo -e "\n---\nDomain: $domain\n---"
domain_delete_disks "$domain"
