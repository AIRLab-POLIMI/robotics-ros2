FROM ros:humble-perception

ENV DEBIAN_FRONTEND=noninteractive

# Set timezone (avoid tzdata prompt)
RUN echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections \
 && echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections

# Base tools
RUN apt-get update && apt-get install -y \
    build-essential nano tmux iputils-ping gdb cmake git \
    openssl libssl-dev libmysqlclient-dev xvfb \
    python3-colcon-common-extensions \
    python3-pip \
    libboost-all-dev \
    ros-humble-ros2-control ros-humble-ros2-controllers \
    ros-humble-moveit ros-humble-depthai-ros ros-humble-moveit-ros-control-interface \
    ros-humble-behaviortree-cpp* ros-humble-ros-testing freeglut3-dev ros-humble-moveit-resources-* \
    ros-humble-realsense2-camera \
    ros-humble-ur-* \
    ros-humble-omni-base* ros-humble-play-motion2 ros-humble-diagnostic-aggregator ros-humble-gazebo*\
    libprotobuf-dev protobuf-compiler ros-humble-tf* \
    ros-humble-rmw-cyclonedds-cpp \
    net-tools iproute2

#Forgottedn
RUN apt-get update && apt-get install -y \
    ros-humble-turtle*

# Create user and group with correct IDs
ARG GROUP_NAME=robotics
ARG GROUP_ID=42042
ARG USER_NAME=robotics
ARG USER_ID=1001

RUN groupadd -g $GROUP_ID $GROUP_NAME && \
    useradd -ms /bin/bash -u $USER_ID -g $GROUP_ID $USER_NAME && \
    echo "$USER_NAME:$USER_NAME" | chpasswd

# Setup workspace as root

WORKDIR /home/$USER_NAME

#Letsgo
CMD ["bash"]

