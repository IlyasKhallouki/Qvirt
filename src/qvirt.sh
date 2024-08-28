#!/bin/bash

source "src/vm_manager.sh"

create_flag=false
# Default values for testing
memory_value=512
disk_value=5
img_value="./test/distributions/alpine_linux.iso"

while getopts ":c:r:l:m:d:i:" opt; do
    case "${opt}" in
        c)
            # If -c is flagged, we expect the next argument to be the VM name
            if [ -n "${OPTARG}" ] && [[ "${OPTARG}" != -* ]]; then
                create_flag=true
                create_name="${OPTARG}"
            else
                create_flag=false
                OPTIND=$((OPTIND - 1))  # Otherwise reprocess this option
            fi
            ;;
        m)
            if [ "$create_flag" = true ]; then
                memory="$OPTARG"
                re='^[0-9]+$'
                if ! [[ $memory =~ $re ]]; then
                    echo "error: Invalid memory value. It's not a number!" >&2
                    exit 1
                fi
                memory_value=$memory
            else
                echo "error: -m option used without -c option" >&2
                exit 1
            fi
            ;;
        d)
            if [ "$create_flag" = true ]; then
                disk="$OPTARG"
                re='^[0-9]+$'
                if ! [[ $disk =~ $re ]]; then
                    echo "error: Invalid disk size value. It's not a number!" >&2
                    exit 1
                fi
                disk_value=$disk
            else
                echo "error: -d option used without -c option" >&2
                exit 1
            fi
            ;;
        i)
            if [ "$create_flag" = true ]; then
                img="${OPTARG}"
                if [ ! -f "$img" ]; then
                    echo "error: Invalid VM img file. It doesn't exist!" >&2
                    exit 1
                else
                    img_value="$img"
                fi
            else
                echo "error: -i option used without -c option" >&2
                exit 1
            fi
            ;;
        r)
            echo "Removing VM with ID ${OPTARG}"
            ;;
        l)
            echo "Listing all VMs"
            ;;
        *)
            echo "Invalid option: -${OPTARG}" >&2
            exit 1
            ;;
    esac
done

if $create_flag; then
    create_vm $create_name $img_value $memory_value $disk_value
fi