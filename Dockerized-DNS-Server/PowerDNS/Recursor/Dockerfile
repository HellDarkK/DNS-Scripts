# Base Image
FROM debian:bookworm

# Install Updates and Dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo curl python3 python3-jinja2 tini libcap2-bin && \
    apt-get clean

# Create the APT source list for PowerDNS
RUN echo 'deb [signed-by=/etc/apt/keyrings/auth-49-pub.asc] http://repo.powerdns.com/debian bookworm-auth-49 main' | tee /etc/apt/sources.list.d/pdns.list

# Create the APT preferences file
RUN echo "Package: auth*" > /etc/apt/preferences.d/auth-49 && \
    echo "Pin: origin repo.powerdns.com" >> /etc/apt/preferences.d/auth-49 && \
    echo "Pin-Priority: 600" >> /etc/apt/preferences.d/auth-49

# Add APT Keyring file
RUN install -d /etc/apt/keyrings && curl https://repo.powerdns.com/FD380FBB-pub.asc | sudo tee /etc/apt/keyrings/auth-49-pub.asc

# Install PowerDNS Authoritative Server
RUN apt-get update && apt-get install -y pdns-server

# Expose PowerDNS Ports (53 for DNS)
EXPOSE 53/tcp 53/udp

# Correct EntryPoint for PowerDNS Authoritative Server
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/sbin/pdns_server", "--daemon=no", "--guardian=no", "--loglevel=9"]
