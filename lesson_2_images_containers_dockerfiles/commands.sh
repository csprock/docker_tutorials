## Images

# Pull the `hello-world` image from Docker Hub
# This command downloads the `hello-world` image, which is a simple test image to verify Docker is working.
docker image pull hello-world:latest

# Pull a specific version of the Python image
# This command downloads the `python:3.11.1-slim-bullseye` image, which is a lightweight Python 3.11.1 image based on Debian Bullseye.
docker pull python:3.11.1-slim-bullseye

# List all Docker images on your system
# This command shows all Docker images currently stored locally, including their repository, tag, size, and creation date.
docker image ls

# Inspect detailed information about an image
# This command provides detailed metadata about the `python:3.11.1-slim-bullseye` image, such as layers, environment variables, and configuration.
docker image inspect python:3.11.1-slim-bullseye

# View the history of an image
# This command shows the layers and commands used to build the `python:3.11.1-slim-bullseye` image.
docker image history python:3.11.1-slim-bullseye

# Remove an image from your local system
# This command deletes the image from your local Docker storage.
docker image rm python:3.11.1-slim-bullseye


## Containers

# Run a container from the `hello-world` image
# This command creates and starts a new container named `my_container` using the `hello-world` image.
# The container will print a message and then stop.
docker run --name my_container hello-world:latest

# List all containers (including stopped ones) and show only the most recently created
# This command lists all containers, including stopped ones, and filters to show only the latest container created.
docker container ls --all --latest

# Start a stopped container in interactive mode
# This command starts the stopped container `my_container` and attaches it to your terminal in interactive mode.
docker container start --interactive my_container

# Remove a container
# This command deletes the container `my_container` from your system. The container must be stopped before it can be removed.
docker rm my_container

# Execute a command inside a running container
# This command opens an interactive Bash shell inside a running container (replace `<container_id>` with the actual container ID).
docker container exec --it <container_id> /bin/bash


## Dockerfiles

# Build a Docker image from a Dockerfile
# This command builds a Docker image using the `Dockerfile` in the current directory (`.`).
# The `--build-arg` flag passes a build argument (`VERSION=3.11`) to the Dockerfile.
# The `--tag` flag assigns a name (`my_test_image`) to the newly built image.
docker build -f Dockerfile . --build-arg VERSION=3.11 --tag my_test_image

# List Docker images and filter for `my_test_image`
# This command lists all Docker images and filters the output to show only the `my_test_image`.
docker image ls | grep my_test_image

# Inspect detailed information about the `my_test_image`
# This command provides detailed metadata about the `my_test_image`, such as its layers, environment variables, and configuration.
docker image inspect my_test_image

# Run a container from the `my_test_image`
# This command creates and starts a new container using the `my_test_image` image.
docker run my_test_image

# Run a container with an environment variable
# This command creates and starts a new container using the `my_test_image` image and sets an environment variable (`MY_VARIABLE=hello`).
# The program inside the container will print the value of the environment variable.
docker run -e MY_VARIABLE=hello my_test_image

# Forcefully remove a running container
# This command forcefully stops and removes a running container created from the `my_test_image`.
docker rm -f my_test_image

