# Use Alpine Linux as the base image
FROM alpine:latest

# Install SSHFS and OpenSSH client
RUN apk add --no-cache sshfs openssh-client

# Create a mount directory inside the container
RUN mkdir -p /mnt/sftp

# Keep the container running
CMD ["sleep", "infinity"]
