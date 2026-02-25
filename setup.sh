#!/bin/bash

# Define variables
GROUP_NAME="robotics"
GROUP_ID=42042

# Create the group robotics with GID 42042 if it doesn't exist
if ! getent group $GROUP_NAME >/dev/null; then
    echo "Creating group $GROUP_NAME with GID $GROUP_ID..."
    sudo groupadd -g $GROUP_ID $GROUP_NAME
else
    echo "Group $GROUP_NAME already exists."
fi

# Add the current user to the robotics group if not already a member
if ! id -nG "$USER" | grep -qw $GROUP_NAME; then
    echo "Adding user $USER to group $GROUP_NAME..."
    sudo usermod -aG $GROUP_NAME $USER
    echo "You may need to log out and log back in for group changes to take effect."
else
    echo "User $USER is already a member of group $GROUP_NAME."
fi

# Change the group owner of the folders colcon_ws and bags to robotics
echo "Changing group ownership of directories colcon_ws and bags to $GROUP_NAME..."
sudo chgrp -R $GROUP_NAME "$PWD/colcon_ws" "$PWD/bags"

sudo chmod 777 "$PWD/colcon_ws" "$PWD/bags"

echo "Script execution completed."
