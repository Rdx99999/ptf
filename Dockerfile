# Use a lightweight base image
FROM alpine:latest

# Install dependencies and download FRP server
RUN apk add --no-cache wget tar \
    && wget https://github.com/fatedier/frp/releases/download/v0.45.0/frp_0.45.0_linux_amd64.tar.gz \
    && tar -zxvf frp_0.45.0_linux_amd64.tar.gz \
    && mv frp_0.45.0_linux_amd64 /frp \
    && rm frp_0.45.0_linux_amd64.tar.gz

# Set the working directory
WORKDIR /frp

# Copy the configuration file
COPY frps.ini .

# Expose the necessary ports
EXPOSE 7000 7500 80 443

# Run the FRP server with the specified config
CMD ["./frps", "-c", "frps.ini"]
