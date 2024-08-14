#!/bin/bash

# Check if the "websites" environment variable is set
if [ "$WEBSITES" ]; then
    # Read the comma-separated list of websites into an array
    IFS=',' read -ra WEBSITES <<< "$WEBSITES"

    for website in "${WEBSITES[@]}"; do
    # Generate a random password

        if [ -n "$PROXY" ]; then
            # Use the proxy if the PROXY variable is set
            npm --proxy "$PROXY" --run grab -- --site="$website" --maxConnections=10 -o "/www/${website}_guide.xml"
            (crontab -l ; echo "$CRON cd /epg/ && npm --proxy \"$PROXY\" run grab -- --site='$website' --maxConnections=10 -o /www/${website}_guide.xml") | crontab -
        else
            # Run without proxy
            npm --run grab -- --site="$website" --maxConnections=10 -o "/www/${website}_guide.xml"
            (crontab -l ; echo "$CRON cd /epg/ && npm run grab -- --site='$website' --maxConnections=10 -o /www/${website}_guide.xml") | crontab -
        fi
    done
fi

# Start Services
npm run serve /epg/www/ & 
crond -f -L /var/log/cron.log
