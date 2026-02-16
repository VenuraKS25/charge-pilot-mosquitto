# Use the official lightweight image
FROM eclipse-mosquitto:2

# Create necessary directories for persistence and logs
RUN mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log

# Copy your custom config file into the container
COPY mosquitto.conf /mosquitto/config/mosquitto.conf

# Fix permissions so the 'mosquitto' user (ID 1883) can write to data
# This is crucial for Railway's volume mounting
RUN chown -R mosquitto:mosquitto /mosquitto

# Tell Railway which port we are listening on
EXPOSE 1883

# Launch Mosquitto using your specific config file
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]