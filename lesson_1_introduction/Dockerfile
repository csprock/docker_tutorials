# Base image: Uses an official Python 3.12.9 slim image as the starting point
# The 'slim' variant has a minimal set of packages installed, resulting in a smaller image
FROM python:3.12.9-slim

# Creates an empty file named app.py
# The 'touch' command is a Linux command that creates an empty file if it doesn't exist
RUN touch app.py

# Writes a simple Python "Hello, World!" program into the app.py file
# The echo command outputs text, and the '>' redirects that output into the file
RUN echo "print('Hello, World!')" > app.py


# Defines the default command to run when the container starts
# This array format ["command", "param1"] is the exec form, which is preferred over shell form (e.g., CMD python app.py)
# When the container starts, it will execute 'python app.py'
CMD ["python", "app.py"]