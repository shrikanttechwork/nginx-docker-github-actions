# Use the official Jenkins LTS image as the base
FROM jenkins/jenkins:lts-jdk17

# Switch to root user to install extra packages
USER root

# Install necessary packages (e.g., Docker CLI, git, etc.)
# The commands below are an example of installing the Docker CLI within the container
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release git && \
    curl -fsSL https://download.docker.com | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && apt-get install -y docker-ce-cli && \
    rm -rf /var/lib/apt/lists/*

# Switch back to the jenkins user
USER jenkins

# (Optional) Install specific Jenkins plugins using the built-in script
# e.g., RUN jenkins-plugin-cli --plugins "blueocean:1.27.2"

