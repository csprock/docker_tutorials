# Build a Docker image using the specified Dockerfile in the current directory
# -f Dockerfile: Specifies which Dockerfile to use (this is the default name, so often omitted)
# .: Specifies the build context (the directory containing files that might be used in the build)
# --tag lesson:1: Names and tags the resulting image as "lesson" with version "1"
docker build -f Dockerfile . --tag lesson:1

# Run a container from the image we just built
# --name my_container: Assigns a custom name to make the container easy to reference
# lesson:1: Specifies which image to use (name:tag format)
# The container will execute the CMD instruction from the Dockerfile and then exit
docker container run --name my_container lesson:1

# Remove the container we just created
# Once a container exits, it remains in the system until explicitly removed
# This frees up resources and keeps your system clean
docker container rm my_container


# Run a container with an interactive terminal
# -it: Combination of -i (interactive) and -t (allocate a pseudo-TTY)
# --name my_container: Assigns a custom name to the container
# lesson:1: Specifies which image to use
# /bin/bash: Overrides the default CMD from the Dockerfile, launching a bash shell instead
# This allows you to explore the container's filesystem and environment interactively
docker container run -it --name my_container lesson:1 /bin/bash

# Remove the container after we're done with it
# This cleanup step is important for managing system resources
docker container rm my_container

# Remove the image we created
# Once you're done with an image, you can remove it to free up disk space
# This removes the "lesson:1" image from your local system
docker image rm lesson:1

