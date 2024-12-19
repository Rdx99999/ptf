FROM jlesage/firefox

# Expose necessary ports for VNC
EXPOSE 5800

# Run the container with necessary options
CMD ["sh", "-c", "docker --allow-root run -v /content/tools/firefox:/config -p 5800:5800 jlesage/firefox"]
