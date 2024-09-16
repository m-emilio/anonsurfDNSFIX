#!/bin/bash
#THIS SCRIPT WILL DELETE THE resolv.conf FILE AND RECREATE IT WITH A QUAD9 DNS

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Delete the existing resolv.conf file
rm -f /etc/resolv.conf

# Create a new resolv.conf file with the nameserver
echo "nameserver 9.9.9.9" > /etc/resolv.conf

# Display a success message
echo "Created a new /etc/resolv.conf with nameserver 9.9.9.9"
