# Use official N8N image from the Docker registry
FROM docker.n8n.io/n8n-io/n8n

# Expose the port N8N will run on
EXPOSE 5678

# Command to run N8N on container startup
CMD ["n8n"]
