FROM ghcr.io/open-webui/open-webui:main

ENV OLLAMA_BASE_URL=https://example.com

VOLUME /app/backend/data

EXPOSE 8080

CMD ["run"]  # Ensure this matches the container's entry point
