# Use a Rust image to build the Bore CLI binary
FROM rust:latest as builder

# Install Bore CLI
RUN cargo install bore-cli

# Create a lightweight runtime image
FROM debian:bullseye-slim

# Copy the Bore CLI binary from the builder
COPY --from=builder /usr/local/cargo/bin/bore /usr/local/bin/bore

# Expose the server port
EXPOSE 8080

# Run the Bore server on Render
CMD ["bore", "server", "--port", "8080"]
