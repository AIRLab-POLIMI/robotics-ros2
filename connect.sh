#!/bin/bash

# Variables
CONTAINER_NAME="robotics"

# Grant X permissions
#xhost +si:localuser:$(whoami)
xhost +local:root
# Check if the container is running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Container $CONTAINER_NAME is running. Connecting to it..."
    docker exec -it $CONTAINER_NAME /bin/bash
else
    echo "Container $CONTAINER_NAME is not running."
fi
