# Use the official n8n Docker image
FROM n8nio/n8n:latest

# Expose the port n8n runs on
EXPOSE 5678

# Set the environment variable for n8n to use
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=http
ENV N8N_BASIC_AUTH_ACTIVE=false
ENV N8N_BASIC_AUTH_USER=n8n
ENV N8N_BASIC_AUTH_PASSWORD=password

# Run n8n when the container starts
CMD ["n8n"]
