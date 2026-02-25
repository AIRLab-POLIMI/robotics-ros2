

# Robotics Docker Image

This repository contains the Dockerfiles to build the Docker image for the robotics course together with a set of scripts to start the container.

The guide assume you are working on some version of Linux (**highly recommended**) 

## How to Get Ready for the robotics course

To use ROS 2 you will need Docker. This allows you to avoid being tied to a specific Ubuntu version to satisfy the ROS–Ubuntu compatibility.

1.  First, install Docker by following the official Docker tutorial (do not install docker desktop): [Install Docker on Ubuntu](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
2.  Test the installation by running the hello-world container: `docker run hello-world`
3.  If you get a permission denied error, add your user to the Docker group: `sudo usermod -aG docker $USER`
4.  Then reboot and try running the hello-world container again.

Once Docker is properly installed, you can get the Docker image for the DRIMS2 summer school:

1. Clone the repository
2. Run the script `setup.sh` this will add the robotics group to your system. Once the script runs succesfully open a new terminal.

## Developing your ROS 2 nodes
The `colcon_ws` folder and the `bags` folder are mounted inside the Docker container and are used for code development. All your code will go inside the `colcon_ws/src` folder. The workspace starts empty so you can create your own packages.
To run your node you will have to start the container and compile the environment, to do so:
1. Run the script `start.sh`
2. Then move inside the workspace directory `cd colcon_ws`
3. Compile the environment with `colcon build`

Now that you have your node compiled you can run them. Since you have only one terminal inside docker you can use `tmux` to create multiple terminals and run all the required commands. For a guide of all basic tmux commands you can reference the [Tmux Cheat Sheet](https://tmuxcheatsheet.com/)

An alternative solution is to open new terminals and connect to the running container. To do so make sure you have started the container with `start.sh`, then in a new terminal run `connect.sh`, the new terminal is now running inside the container. While you can only run the `start.sh` once, because you can only have one running container named `robotics`, you can use the `connect.sh` script as many time as you want, since you are connecting to a running container.

## Extras

-   `start.sh`: Starts the container in interactive mode
-   The `docker` folder contains the Dockerfile to build the robotics image and a script to build the image for multiple architectures using Buildx.
-   The `colcon_ws` folder is the workspace used to develop new code, mounted on `/colcon_ws` inside the Docker container.
- The *bags* folder is a support folder to allow bags recordings and see provided data inside the docker container. It is mounted in your home, under /home/robotics/bags in the docker container.

## Windows users

WSL 2 should work decently, allow you to have some form of GUI, etc. 
Ubuntu is still the preferred option, but you can try WSL if you don't have Ubuntu installed 


## VS-Code integration	
To write your code you can use nano/vim directly inside docker.
If you want to use any ide, they usually provide plugins to connect to a running docker container.
For VS-code: 
1. Install the Dev Containers plugin
2. Click on the green `><` icon in the bottom-left corner of the VS Code window to open the Remote - Containers menu
3. Select `Remote-Containers: Attach to Running Container...`
4. A list of running containers will appear. Select the container you want to connect to.
5. VS Code will then attach to the selected container and open a new VS Code window connected to that container.
6. You can also install the c++ and ros extensions of vs code to have autocomplete and errors hilights 

## GUIs
Docker is primarily designed to be used from the terminal, which means it doesn't natively support graphical user interfaces (GUIs). However, when working with ROS, Gazebo, and MoveIt, having a GUI can be very helpful.

### Unsafe Method (Not Recommended)
The easiest but least secure method is to grant permission to all local users, including root, to connect to the X server. This can be done by running the following command before starting your Docker container:

`xhost +local:root`

This method is not recommended as it opens up your X server to any local user, which can be a significant security risk.

### Safer Method
A safer option is to allow only the current user to connect to the X server. You can do this by running:

`xhost +si:localuser:$(whoami)`

This command limits access to the X server to your current user only, making it a more secure alternative.

### Automating X Server Access Setup
If you don't want to manually run the xhost command every time you open a terminal, you can automate it by adding the command to your .bashrc file. This way, the command will run automatically whenever you start a new terminal session.
To do this, run the following command once:

`echo "xhost +si:localuser:$(whoami) > /dev/null 2>&1" >> ~/.bashrc`

This will add the safer xhost command to your .bashrc file, ensuring it runs without displaying any output in your terminal.

Nevertheless, the start script already enable gui, so if you use the provided script you don't have to set any additional variable 



