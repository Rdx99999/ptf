FROM accetto/xubuntu-vnc-novnc

# Expose necessary ports for VNC and noVNC
EXPOSE 5901
EXPOSE 6901

# Optionally, you can add any necessary configuration or commands here

CMD ["sh", "-c", "docker --allow-root run -v -p 5902:5901 -p 6902:6901 accetto/xubuntu-vnc-novnc"]
