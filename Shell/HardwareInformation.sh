# Display messages in kernel ring buffer
dmesg

# Display CPU information
cat /proc/cpuinfo

# Display memory information
cat /proc/meminfo

# Display free and used memory ( -h for human readable, -m for MB, -g for GB.)
free -h

# Display PCI devices
lspci -tv

# Display USB devices
lsusb -tv

# Display DMI/SMBIOS (hardware info) from the BIOS
dmidecode

# Show info about disk sda
hdparm -i /dev/sda

# Perform a read speed test on disk sda
hdparm -tT /dev/sda

# Test for unreadable blocks on disk sda
badblocks -s /dev/sda