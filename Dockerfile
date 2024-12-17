# Base image
FROM n8nio/n8n:latest

# Expose port
EXPOSE 5678

# Run n8n
CMD ["n8n", "start"]
