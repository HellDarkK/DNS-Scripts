# Base Image
FROM debian:bookworm

# Install Updates and Dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo curl python3 python3-jinja2 tini libcap2-bin && \
    apt-get clean

# Create the APT source list for PowerDNS
RUN echo 'deb [signed-by=/etc/apt/keyrings/dnsdist-master-pub.asc] http://repo.powerdns.com/debian bookworm-dnsdist-master main' | tee /etc/apt/sources.list.d/pdns.list

# Create the APT preferences file
RUN echo "Package: dnsdist*" > /etc/apt/preferences.d/dnsdist-master && \
    echo "Pin: origin repo.powerdns.com" >> /etc/apt/preferences.d/dnsdist-master && \
    echo "Pin-Priority: 600" >> /etc/apt/preferences.d/dnsdist-master

# Add APT Keyring file
RUN install -d /etc/apt/keyrings && curl https://repo.powerdns.com/CBC8B383-pub.asc | sudo tee /etc/apt/keyrings/dnsdist-master-pub.asc

# Install PowerDNS Authoritative Server
RUN apt-get update && apt-get install -y dnsdist

# Expose PowerDNS Ports (53 for DNS)
EXPOSE 53/tcp 53/udp

# Correct EntryPoint for PowerDNS DNSDist
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/sbin/dnsdist", "--supervised", "--disable-syslog"]
