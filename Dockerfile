# Use the latest Ubuntu base image
FROM ubuntu:latest

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Update and install essential dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    sudo \
    tzdata \
    dbus-x11 \
    x11-utils \
    x11-xserver-utils \
    libx11-xcb1 \
    fonts-liberation \
    gsettings-desktop-schemas \
    libnspr4 \
    libnss3 \
    xfce4 \
    xfce4-terminal \
    desktop-base \
    xscreensaver \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and install Chrome Remote Desktop
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && \
    dpkg --install chrome-remote-desktop_current_amd64.deb || apt-get install -y --fix-broken && \
    rm chrome-remote-desktop_current_amd64.deb

# Verify CRD installation
RUN if [ ! -f /opt/google/chrome-remote-desktop/start-host ]; then echo "CRD installation failed" && exit 1; fi

# Install Google Chrome browser
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg --install google-chrome-stable_current_amd64.deb || apt-get install -y --fix-broken && \
    rm google-chrome-stable_current_amd64.deb

# Add a new user
ARG USERNAME=user
ARG PASSWORD=root
RUN useradd -m ${USERNAME} && echo "${USERNAME}:${PASSWORD}" | chpasswd && \
    usermod -aG sudo ${USERNAME} && \
    sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

# Add the user to the Chrome Remote Desktop group
RUN usermod -a -G chrome-remote-desktop ${USERNAME}

# Configure Chrome Remote Desktop for XFCE
RUN echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session && \
    chmod +x /etc/chrome-remote-desktop-session

# Expose the Chrome Remote Desktop authentication variables
ENV CRP="DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AeanS0ZqqPad_L3NxmsCh5YwPiFEaU-v9yGPxclLeeOW_CkSO_rbnoUAHv5QiqTVcphJRw" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)"
ENV PIN=123456

# Command to initialize Chrome Remote Desktop on the first run
CMD if [ ! -z "$CRP" ]; then su - ${USERNAME} -c "$CRP --pin=$PIN"; fi && service chrome-remote-desktop start && bash
