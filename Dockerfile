FROM nginx:latest

# Copy custom NGINX config
COPY nginx.conf /etc/nginx/nginx.conf

# Expose the port for the proxy
EXPOSE 80

# Default entrypoint for NGINX
CMD ["nginx", "-g", "daemon off;"]
