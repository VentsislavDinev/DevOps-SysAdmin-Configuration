# View all available partitions on Linux. 
fdisk -l

# Display all disk partitions of device /dev/sda
fdisk -l /dev/sda

fdisk /dev/sda

# format sda4 partition 
mkfs.ext4 /dev/sda4

# Check size partition
fdisk -s /dev/sda2