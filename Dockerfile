FROM debian:trixie-slim

# Set environment variables
ENV ADGUARD_USERNAME=admin
ENV ADGUARD_PASSWORD=admin

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    apache2-utils \
    unbound \
    dnsutils \
    ca-certificates && \
    apt-get clean


# Set up Unbound Control and permissions
RUN unbound-control-setup && \
    chown -R unbound:unbound /var/lib/unbound && \
    chmod -R 755 /var/lib/unbound && \
    chown -R unbound:unbound /etc/unbound && \
    chmod -R 755 /etc/unbound

# Download root hints (no need for sudo here)
RUN curl -s https://www.internic.net/domain/named.root -o /var/lib/unbound/root.hints

# Copy unbound config file
COPY ./adguardhome.conf /etc/unbound/unbound.conf.d/adguardhome.conf

# Install AdGuard
RUN curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s --

# Expose ports for DNS, AdGuardHome, and DoH
EXPOSE 53/tcp 53/udp 67/udp 68/udp 80/tcp 443/tcp 443/udp 3000/tcp \
       853/tcp 784/udp 853/udp 8853/udp 5443/tcp 5443/udp

RUN mkdir -p /opt/AdGuardHome/conf/ && \
    mkdir -p /opt/AdGuardHome/work/

# Copy adguard home config file creation script
COPY ./create_adguard_config.sh /usr/bin/create_adguard_config

# Make script executable
RUN chmod +x /usr/bin/create_adguard_config

RUN chmod 700 /opt/AdGuardHome

VOLUME /opt/AdGuardHome/conf/
VOLUME /opt/AdGuardHome/work/

WORKDIR /opt/AdGuardHome/work/

# Command to start both Unbound and AdGuard
CMD ["bash", "-c", "service unbound start && /usr/bin/create_adguard_config && /opt/AdGuardHome/AdGuardHome -c /opt/AdGuardHome/conf/AdGuardHome.yaml -w /opt/AdGuardHome/work"]