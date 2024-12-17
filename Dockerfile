# Use Node.js v22.12.01 runtime as the parent image
FROM node:22.12.0-alpine

# Set the working directory
WORKDIR /app

# Install required dependencies for npx (e.g., bash)
RUN apk add --no-cache bash

# Expose port 5678 for the n8n web interface
EXPOSE 5678

# Run n8n using npx when the container starts
CMD ["npx", "n8n"]
