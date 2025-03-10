
# Check the installed version of Docker Compose
# This is useful to confirm that Docker Compose is properly installed and to know which features are supported
# Docker Compose is a tool for defining and running multi-container Docker applications
docker compose --version 

# Build or rebuild all services defined in your docker-compose.yml file
# This command reads the docker-compose.yml file in the current directory and builds any services that have a 'build' section
# Unlike 'docker build', this handles building multiple containers and their relationships at once
# No need to run separate build commands for each container in your application
docker compose build 

# Create and start all containers defined in your docker-compose.yml file
# This single command performs several steps: creates networks, volumes, builds images if needed, and starts containers
# Services will start in dependency order (if specified using 'depends_on')
# By default, this command runs in the foreground and shows the combined output of all containers
# To run in the background (detached mode), you can add '-d' flag as in 'docker compose up -d'
docker compose up