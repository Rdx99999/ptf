# Use the official n8n Docker image
FROM n8nio/n8n:latest

# Set environment variables (optional for customization)
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=http
ENV N8N_BASIC_AUTH_ACTIVE=false
ENV N8N_BASIC_AUTH_USER=n8n
ENV N8N_BASIC_AUTH_PASSWORD=password
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Expose port for the n8n web interface
EXPOSE 5678

# Run n8n when the container starts
CMD ["docker run -it --rm --name n8n -p 5678:5678 docker.n8n.io/n8n-io/n8n"]
