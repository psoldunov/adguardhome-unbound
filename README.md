# psoldunov/adguardhome-unbound

Docker image that ships AdGuard Home and Unbound together.

## Installation

To create the container:

```sh
docker run -d \
  --name adguardhome-unbound \
  --restart unless-stopped \
  -v /path/to/your/conf/folder:/opt/AdGuardHome/conf \
  -p 53:53/tcp \
  -p 53:53/udp \
  # -p 67:67/udp \ # use only if needed
  # -p 68:68/udp \ # use only if needed
  -p 80:80/tcp \
  -p 443:443/tcp \
  -p 443:443/udp \
  -p 3000:3000/tcp \
  -p 853:853/tcp \
  -p 853:853/udp \
  -p 5443:5443/tcp \
  -p 5443:5443/udp \
  -p 6060:6060/tcp \
  psoldunov/adguardhome-unbound:latest-arm64 # or latest-amd64 if you're on x86-64
```

Once deployed, go to `http://**YOUR_IP**:3000` to login to your dashboard using **`"admin/admin"`** credentials.

## Post installation instructions

To change default username/password please refer to this page - [https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#password-reset](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#password-reset).

## Aditional Documentation

All of the documentation related to AdGuard Home can be found [here](https://github.com/AdguardTeam/AdGuardHome).

Enjoy.
