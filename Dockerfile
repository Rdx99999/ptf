FROM jlesage/firefox

# Set working directory (optional)
WORKDIR /content/tools/firefox

# Expose port
EXPOSE 5800

# Command to run the container when it's started
CMD ["--allow-root", "run", "-v", "/content/tools/firefox:/config", "-p", "5800:5800"]
