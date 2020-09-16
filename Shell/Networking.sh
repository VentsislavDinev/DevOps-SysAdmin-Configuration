# Display all network interfaces and ip address
ifconfig -a

# Display eth0 address and details
ifconfig eth0

# Query or control network driver and hardware settings
ethtool eth0

# Send ICMP echo request to host
ping host

# Display whois information for domain
whois domain

# Display DNS information for domain
dig domain

# Reverse lookup of IP_ADDRESS
dig -x IP_ADDRESS

# Display DNS ip address for domain
host domain

# Display the network address of the host name.
hostname -i

# Display all local ip addresses
hostname -I

# Download http://domain.com/file
wget http://domain.com/file

# Display listening tcp and udp ports and corresponding programs
netstat -nutlp