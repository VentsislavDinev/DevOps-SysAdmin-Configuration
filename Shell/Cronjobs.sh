# Check if package is installed
rpm -q cronie

# Check if service is running
systemctl status crond.service	

# List current users crontab
crontab -l	

# Edit current users crontab
crontab -e	

# Edit specific users crontab
crontab -e -u username	

# Remove current users crontab
crontab -r	