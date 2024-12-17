# Use official n8n image
FROM docker.n8n.io/n8n-io/n8n

# Expose the default n8n port
EXPOSE 5678

# Run n8n
CMD ["n8n", "start"]
