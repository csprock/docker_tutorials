FROM alpine:latest

RUN mkdir -p /mydir

# Create a file with some content
# This command creates a file (`file1.txt`) in the `/mydir` directory and writes "file content" into it.
# The file is created during the image build process and becomes part of the final image.
# This demonstrates how you can pre-populate files in your Docker image.
RUN echo "file content" > /mydir/file1.txt

# Output the contents of the file to the console.
CMD ["cat", "/mydir/file1.txt"]