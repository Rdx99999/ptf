# Use the specified image from the GitHub Container Registry
FROM ghcr.io/open-webui/open-webui:main

# Set working directory inside the container
WORKDIR /app

# Expose the necessary port
EXPOSE 8080

# Command to start the container
CMD ["./start.sh"]
