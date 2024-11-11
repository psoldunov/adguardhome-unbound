#!/usr/bin/env bash

# Define the directory and file path
CONF_DIR="/opt/AdGuardHome/conf"
CONF_FILE="$CONF_DIR/AdGuardHome.yaml"

# Check if the required environment variables are set
if [ -z "$ADGUARD_USERNAME" ] || [ -z "$ADGUARD_PASSWORD" ]; then
    echo "ERROR: ADGUARD_USERNAME or ADGUARD_PASSWORD environment variable is not set."
    exit 1
fi

# Generate the bcrypt hash using htpasswd
ENCRYPTED_PASSWORD=$(htpasswd -B -C 10 -n -b "$ADGUARD_USERNAME" "$ADGUARD_PASSWORD" | cut -d ":" -f 2)

if [ -z "$ENCRYPTED_PASSWORD" ]; then
    echo "ERROR: Failed to generate the encrypted password!"
    exit 1
fi

# Check if the configuration directory exists
if [ ! -d "$CONF_DIR" ]; then
    echo "Configuration directory doesn't exist, creating it..."
    mkdir -p "$CONF_DIR"
fi

# Check if the file already exists
if [ -f "$CONF_FILE" ]; then
    echo "File '$CONF_FILE' already exists. No change made."
    # If you want to update the file dynamically, you can add more logic here.
else
    echo "File '$CONF_FILE' does not exist. Creating it now..."
    # Write content to the AdGuardHome.yaml file with dynamic username and password
    cat <<EOF > "$CONF_FILE"
users:
  - name: $ADGUARD_USERNAME
    password: $ENCRYPTED_PASSWORD
dns:
  bind_hosts:
    - 0.0.0.0
  port: 53
  upstream_dns:
    - 127.0.0.1:5335
  cache_size: 0
EOF
    # Feedback message
    echo "'$CONF_FILE' has been created successfully with user '$ADGUARD_USERNAME'."
fi