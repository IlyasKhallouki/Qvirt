#!/bin/bash

create_flag=false
memory_value=512
img_value="./test/distributions/alpine_linux.iso"

while getopts ":c:r:l:m:i:" opt; do
    case "${opt}" in
        c)
            name="${OPTARG}"
            if [ -z "$name" ]; then
                echo "error: Invalid VM name. It's empty!" >&2
                exit 1
            else
                create_flag=true
                create_name=$name
            fi
            ;;
        m)
            memory="$OPTARG"
            re='^[0-9]+$'
            if [ -z "$memory" ] && $create_flag; then
                echo "error: Invalid VM memory value. It's empty!" >&2
                exit 1
            elif ! [[ $memory =~ $re ]] && $create_flag ; then
                echo "error: Invalid memory value. It's not a number!" >&2
                exit 1
            fi
            memory_value=$memory
            ;;
        i)
            img="${OPTARG}"
            if [ -z "$img" ] && $create_flag; then
                echo "error: Invalid VM img directory. It's empty!" >&2
                exit 1
            elif [ ! -f "$img" ] && $create_flag; then
                echo "error: Invalid VM img file. It doesn't exist!"
            else
                img_value="$img"
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
        

echo $create_flag
echo $create_name
echo $memory_value
echo $img_value