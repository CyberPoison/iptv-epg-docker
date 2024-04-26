# Use Alpine Linux as the base image
FROM alpine:latest

# Copy Start Script
COPY start.sh /app/start.sh

# chmod the script
RUN chmod +x /app/start.sh

# Install git and Node.js
RUN apk update && \
    apk add --no-cache git nodejs npm bash && \
    npm install -g npm

# Clone the repository, install dependencies, and set working directory
RUN git clone --depth 1 -b master https://github.com/iptv-org/epg.git && \
    cd epg && \
    npm install
    
# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Create epg directory
RUN mkdir /epg/www/

# Current directory
WORKDIR /epg

# Expose port 3000
EXPOSE 3000

# Default env
ENV WEBSITES="meo.pt,chaines-tv.orange.fr,sky.com"

# Run the command when the container starts
CMD ["/bin/bash", "/app/start.sh"]