# illustrate the use of a bind mount by overwriting the file in the container

# Build a Docker image from a Dockerfile
docker image build --file Dockerfile . --tag example:latest

# Run a container from the newly built image
# The container will execute the default command specified in the Dockerfile (e.g., printing the contents of a file).
docker container run --name example_container example:latest

# Remove the container
docker container rm example_container

# Run a container with a bind mount
# This command starts a new container with a bind mount, linking a directory on the host to a directory in the container.
# - `--mount type=bind,source=$(pwd)/mydir,destination=/mydir`:
#   - `type=bind`: Specifies that this is a bind mount.
#   - `source=$(pwd)/mydir`: The path to the directory on the host machine. `$(pwd)` resolves to the current working directory.
#   - `destination=/mydir`: The path inside the container where the host directory will be mounted.
# - `--name example_container`: Names the container `example_container`.
# - `example:latest`: Specifies the image to use.
# The container will execute the default command specified in the Dockerfile (e.g., printing the contents of a file), 
# which in this case will be the contents of the file in the bind-mounted directory.
docker container run --mount type=bind,source=$(pwd)/mydir,destination=/mydir \
    --name example_container example:latest

# Remove the container and image
docker container rm example_container
docker image rm example:latest

## volume example

# Create a Docker volume
# This command creates a Docker volume named `my_volume`.
# Volumes are managed by Docker and provide a way to persist and share data between containers.
# Unlike bind mounts, volumes are completely managed by Docker and are stored in a dedicated directory on the host.
docker volume create my_volume

# Run the first container to create a file in the volume
# This command starts a container named `container1` and creates a file in the mounted volume.
# - `--mount type=volume,source=my_volume,destination=/mydir`:
#   - `type=volume`: Specifies that this is a Docker volume.
#   - `source=my_volume`: The volume to mount (`my_volume`).
#   - `destination=/mydir`: The path inside the container where the volume will be mounted.
# - `--name container1`: Names the container `container1`.
# - `alpine:latest`: Uses the lightweight Alpine Linux image.
# - `touch /mydir/file2.txt`: Creates an empty file named `file2.txt` in the mounted volume.
docker run --mount type=volume,source=my_volume,destination=/mydir \
    --name container1 alpine:latest touch /mydir/file2.txt

# Run the second container to list the contents of the volume
# This command starts another container named `container2` and lists the files in the mounted volume.
# - `--mount type=volume,source=my_volume,destination=/mydir`:
#   - Mounts the same volume (`my_volume`) to the `/mydir` directory in this container.
# - `--name container2`: Names the container `container2`.
# - `alpine:latest`: Uses the same Alpine Linux image.
# - `ls /mydir`: Lists the contents of the `/mydir` directory, which is the mounted volume.
docker run --mount type=volume,source=my_volume,destination=/mydir \
    --name container2 alpine:latest ls /mydir

# Expected output:
# The second container will list the files in the volume, including `file2.txt` created by the first container.
# Output: "file2.txt"

# Remove the containers
# This command deletes the containers named `container1` and `container2`.
# The `rm` command removes stopped containers. If the containers are still running, use the `-f` flag to force removal.
docker container rm container1 container2

# Remove the Docker volume
# This command deletes the volume named `my_volume`.
# Use this to clean up after the demonstration. Be careful, as this will permanently delete the volume and its data.
docker volume rm my_volume


