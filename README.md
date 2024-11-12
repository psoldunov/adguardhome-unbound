# psoldunov/adguardhome-unbound

Docker image that ships AdGuard Home and Unbound together. Meant to be used as a drop-in replacement for the official AdGuard Home Docker Image.

## Installation Guide

To deploy the Docker container for AdGuard Home with Unbound, execute the following command:

```sh
docker run -d \
  --name adguardhome-unbound \
  --restart unless-stopped \
  -v /path/to/your/conf/folder:/opt/AdGuardHome/conf \
  -v /path/to/your/work/folder:/opt/AdGuardHome/work \
  -e ADGUARD_USERNAME=YOUR_USERNAME \ # Optional, default: "admin"
  -e ADGUARD_PASSWORD=YOUR_PASSWORD \ # Optional, default: "admin"
  -p 53:53/tcp \
  -p 53:53/udp \
  # -p 67:67/udp \ # Use only if necessary
  # -p 68:68/udp \ # Use only if necessary
  -p 80:80/tcp \
  -p 443:443/tcp \
  -p 443:443/udp \
  -p 3000:3000/tcp \
  -p 853:853/tcp \
  -p 853:853/udp \
  -p 5443:5443/tcp \
  -p 5443:5443/udp \
  -p 6060:6060/tcp \
  psoldunov/adguardhome-unbound:latest-arm64 # For ARM64 architecture
  # Or
  psoldunov/adguardhome-unbound:latest-amd64 # For x86-64 architecture
```

### Accessing the Dashboard
Once the container is running, navigate to `http://<YOUR_IP>:3000` in your web browser to access the AdGuard Home dashboard. Use the provided credentials (or defaults):

**Default Credentials:**
- **Username:** `admin`
- **Password:** `admin`

### Post-Installation Steps

If you are migrating from an existing AdGuard Home setup, ensure to set `127.0.0.1:5335` as the ONLY upstream DNS server. In addition, disable DNS caching by removing the DNS "Cache size" configuration.

To update the administrator username or password, refer to the AdGuard Home documentation [here](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#password-reset).

### Additional Resources
For more detailed documentation and support regarding AdGuard Home, please visit the [official documentation page](https://github.com/AdguardTeam/AdGuardHome).

Enjoy your improved DNS and privacy protection!

--- 

*Note:* Be sure to customize the paths and environment variables in the `docker run` command to suit your local setup.
