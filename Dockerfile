# Use the base image from the GitHub Container Registry
FROM ghcr.io/open-webui/open-webui:main

# Set the working directory inside the container
WORKDIR /app

# Expose the internal port used by the application
EXPOSE 8080

# Default command to run the application
CMD ["./start.sh"]
