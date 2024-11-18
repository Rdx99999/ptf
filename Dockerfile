# Use the official Caddy image
FROM caddy:latest

# Copy the Caddyfile into the container
COPY Caddyfile /etc/caddy/Caddyfile

# Expose necessary ports
EXPOSE 80 443

# Use the default entrypoint provided by the Caddy image
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
