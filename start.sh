#!/bin/bash

# Check if the "websites" environment variable is set
if [ "$WEBSITES" ]; then
    # Read the comma-separated list of websites into an array
    IFS=',' read -ra WEBSITES <<< "$WEBSITES"

    # Iterate over each website
    for website in "${WEBSITES[@]}"; do
        # Generate a random password
        npm run grab -- --site="$website" --maxConnections=10 -o "/www/${website}_guide.xml"
        (crontab -l ; echo $CRON 'cd /epg/ && npm run grab -- --site='$website' --maxConnections=10 -o /www/'${website}'_guide.xml') | crontab -
    done
fi

# Start Services
npm run serve /epg/www/ & 
crond -f -L /var/log/cron.log
