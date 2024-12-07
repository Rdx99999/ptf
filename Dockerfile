# Use the latest Ubuntu image
FROM ubuntu:latest

# Set environment variables to ensure non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Update and install core dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    sudo \
    dbus-x11 \
    x11-utils \
    libx11-xcb1 \
    fonts-liberation \
    gsettings-desktop-schemas \
    libnspr4 \
    libnss3 \
    tzdata \
    xfce4 \
    xfce4-terminal \
    desktop-base \
    xscreensaver \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Chrome Remote Desktop
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && \
    dpkg --install chrome-remote-desktop_current_amd64.deb || apt-get install -y --fix-broken && \
    rm chrome-remote-desktop_current_amd64.deb && \
    test -f /opt/google/chrome-remote-desktop/start-host || (echo "CRD installation failed" && exit 1)

# Install Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg --install google-chrome-stable_current_amd64.deb || apt-get install -y --fix-broken && \
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
RUN usermod -a -G chrome-remote-desktop ${USERNAME}

# Add environment variable to pass the CRD setup command
ENV CRP="DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AeanS0ZqqPad_L3NxmsCh5YwPiFEaU-v9yGPxclLeeOW_CkSO_rbnoUAHv5QiqTVcphJRw" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)"
ENV PIN=123456

# Verify the CRD installation and set up Chrome Remote Desktop
CMD if [ ! -f /opt/google/chrome-remote-desktop/start-host ]; then echo "CRD not installed correctly" && exit 1; fi && \
    if [ ! -z "$CRP" ]; then su - ${USERNAME} -c "$CRP --pin=$PIN"; fi && service chrome-remote-desktop start && bash
