#!/bin/bash

# Function to display help message
view_help() {
    echo "Usage: $0 --email --name --phone someFile.txt"
    echo
    echo "Options:"
    echo "  --name     Specify name to search. Full name, and correct spelling required"
    echo "  --help     Display help message."
}


if [ $# -eq 0 ]; then
    view_help
    exit 1
fi

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in

        --name)
            name="$2"
            shift 2
            ;;
        --help)
            view_help
            exit 0
            ;;
        *)
            file="$1"
            shift
            ;;
    esac
done

# Check if a file is provided
if [ -z "$file" ]; then
    echo "Error: Need a file to check against. See Usage statement."
    view_help
    exit 1
fi

# check for misspellings or similar entries
search_pattern() {
    local pattern=$1
    local description=$2
    if grep -q "$pattern" "$file"; then
        echo "$description '$pattern' found in '$file'."
    else
        echo "$description '$pattern' not found in '$file'."
    fi
}

# Search name
if [ -n "$name" ]; then
    search_pattern "$name" "Name"
fi
