# Use the n8n official image from Docker Hub
FROM docker.n8n.io/n8n-io/n8n

# Expose the n8n port
EXPOSE 5678

# Start n8n on container startup
CMD ["n8n", "start"]
