# Use the official Caddy image
FROM caddy:latest

# Copy the Caddyfile into the container
COPY Caddyfile /etc/caddy/Caddyfile

# Expose necessary ports
EXPOSE 80
EXPOSE 443

# Run Caddy when the container starts
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
