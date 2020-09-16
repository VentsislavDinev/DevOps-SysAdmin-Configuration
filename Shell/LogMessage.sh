
# Show all collected log messages
journalctl

# See network service messages
journalctl -u network.service

# Follow messages as they appear
journalctl -f

# Show only kernel messages
journalctl -k