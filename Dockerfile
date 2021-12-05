FROM jasonrivers/nagios:4.4.6

# Copy custom config files
COPY /config/commands.cfg /opt/nagios/etc/objects/
COPY /config/flights.cfg /opt/nagios/etc/objects/
COPY /config/nagios.cfg /opt/nagios/etc/

