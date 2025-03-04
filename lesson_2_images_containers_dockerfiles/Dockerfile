# Define a build argument
# Build arguments (`ARG`) allow you to pass dynamic values into the Dockerfile during the build process.
# This makes your Dockerfile reusable and flexible. For example, you can build the same Dockerfile
# with different Python versions by passing `--build-arg VERSION=<version>` during the build.
# Here, `VERSION` is a placeholder that will be replaced with the value you provide when building the image.
ARG VERSION

# Use the official Python image as the base image
# The `FROM` instruction specifies the base image for your Docker image. A base image provides the
# foundational layer for your application, including the operating system and runtime environment.
# In this case, we're using the official Python image, and the version is dynamically set by the `VERSION` argument.
# Using an official image ensures reliability and security, as these images are maintained by the Docker team.
FROM python:${VERSION}

# Add metadata to the image
# The `LABEL` instruction adds metadata to your Docker image. Metadata is useful for documentation,
# organization, and filtering images. For example, you can filter images by author or version using Docker commands.
# While not required, adding metadata is a best practice for maintaining and sharing Docker images.
LABEL author=carson
LABEL version=0.0

# Create a directory for the application
# The `RUN` instruction executes commands in the shell during the image build process.
# Here, we create a directory (`/app`) to store the application code. Organizing your application
# files into a dedicated directory keeps the image clean and makes it easier to manage.
RUN mkdir -p /app

# Set an environment variable
# The `ENV` instruction sets environment variables inside the container. Environment variables are
# key-value pairs that can be accessed by processes running in the container. They are often used to
# configure application behavior, such as setting debug modes or API keys.
# In this case, we set `MY_VARIABLE` to `hello`. This variable can be overridden when running the container
# using the `-e` flag with `docker run`.
ENV MY_VARIABLE=hello

# Copy application files into the container
# The `COPY` instruction copies files or directories from the host machine (your computer) into the
# container's filesystem. This is how you include your application code, configuration files, and
# dependencies in the image.
# Here, we copy two files:
# - `app.py`: The main Python script for the application.
# - `requirements.txt`: A file listing Python dependencies to install.
# These files are copied into the `/app` directory we created earlier.
COPY ./app.py /app/app.py
COPY ./requirements.txt /app/requirements.txt

# Install Python dependencies
# The `RUN` instruction is used again to execute commands during the build process.
# Here, we use `pip` (Python's package installer) to install the dependencies listed in `requirements.txt`.
# Installing dependencies during the build process ensures that the image is self-contained and ready to run
# without requiring additional setup when the container starts.
RUN pip install -r /app/requirements.txt

CMD ["python", "/app/app.py"]