# Use the official Caddy image from Docker Hub
FROM caddy:latest

# Copy your Caddyfile into the container
COPY Caddyfile /etc/caddy/Caddyfile

# Expose necessary ports
EXPOSE 80
EXPOSE 443

# Start Caddy when the container starts
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
