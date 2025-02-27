# Base Image
FROM debian:bookworm

# Install Updates and Dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo curl python3 python3-jinja2 tini libcap2-bin && \
    apt-get clean

# Create the APT source list for PowerDNS
RUN echo 'deb [signed-by=/etc/apt/keyrings/rec-master-pub.asc] http://repo.powerdns.com/debian bookworm-rec-master main' | tee /etc/apt/sources.list.d/pdns.list

# Create the APT preferences file
RUN echo "Package: rec*" > /etc/apt/preferences.d/rec-master && \
    echo "Pin: origin repo.powerdns.com" >> /etc/apt/preferences.d/rec-master && \
    echo "Pin-Priority: 600" >> /etc/apt/preferences.d/rec-master

# Add APT Keyring file
RUN install -d /etc/apt/keyrings && curl https://repo.powerdns.com/FD380FBB-pub.asc | sudo tee /etc/apt/keyrings/rec-master-pub.asc

# Install PowerDNS Authoritative Server
RUN apt-get update && apt-get install -y pdns-recursor

# Expose PowerDNS Ports (53 for DNS)
EXPOSE 53/tcp 53/udp

# Correct EntryPoint for PowerDNS Recursor
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/sbin/pdns-recursor", "--daemon=no", "--write-pid=no", "--disable-syslog", "--log-timestamp=no"]
