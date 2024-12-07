# Use the latest Ubuntu image
FROM ubuntu:latest

# Set environment variables to ensure non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Update and install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    wget \
    curl \
    xfce4 \
    xfce4-terminal \
    desktop-base \
    xscreensaver \
    dbus-x11 \
    x11-utils \
    libx11-xcb1 \
    fonts-liberation \
    tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Chrome Remote Desktop
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && \
    dpkg --install chrome-remote-desktop_current_amd64.deb || apt-get install --assume-yes --fix-broken && \
    rm chrome-remote-desktop_current_amd64.deb

# Install Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg --install google-chrome-stable_current_amd64.deb || apt-get install --assume-yes --fix-broken && \
    rm google-chrome-stable_current_amd64.deb

# Add a new user and configure it
ARG USERNAME=user
ARG PASSWORD=root
RUN useradd -m ${USERNAME} && echo "${USERNAME}:${PASSWORD}" | chpasswd && \
    usermod -aG sudo ${USERNAME} && \
    sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

# Configure Chrome Remote Desktop for XFCE
RUN echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session && \
    chmod +x /etc/chrome-remote-desktop-session

# Add the user to the Chrome Remote Desktop group
RUN groupadd chrome-remote-desktop && usermod -a -G chrome-remote-desktop ${USERNAME}

# Add environment variable to pass the CRD setup command
ENV CRP="DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AeanS0bjzJ99nGYWz7_QKgiTQH4SQqFMeTCn1yZavaHGyD87UvtyTRQQbNymE4UhJVdHxg" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)"
ENV PIN=123456

# Command to execute the CRD setup command during build or container startup
CMD if [ ! -z "$CRP" ]; then su - ${USERNAME} -c "$CRP --pin=$PIN"; fi && service chrome-remote-desktop start && bash
