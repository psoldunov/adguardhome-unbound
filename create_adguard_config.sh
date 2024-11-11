#!/usr/bin/env bash

# Define the directory and file path
CONF_DIR="/opt/AdGuardHome/conf"
CONF_FILE="$CONF_DIR/AdGuardHome.yaml"

# Check if the configuration directory exists
if [ ! -d "$CONF_DIR" ]; then
    echo "Configuration directory doesn't exist, creating it..."
    mkdir -p "$CONF_DIR"
fi

# Check if the file already exists
if [ -f "$CONF_FILE" ]; then
    echo "File '$CONF_FILE' already exists. No change made."
else
    echo "File '$CONF_FILE' does not exist. Creating it now..."

    # Write your `AdGuardHome.yaml` content to the file
    cat <<EOF > "$CONF_FILE"
users:
  - name: admin
    password: \$2y\$10\$HhOqcjZkbZ0.KGTnrBACk.N9PtZq74YZ.gcORbz6M2Idbz5eewVAa
dns:
  bind_hosts:
    - 0.0.0.0
  port: 53
  upstream_dns:
    - 127.0.0.1:5335
  cache_size: 0
EOF

    # Feedback message
    echo "'$CONF_FILE' has been created successfully."
fi