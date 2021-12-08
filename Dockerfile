FROM jasonrivers/nagios:4.4.6

# Install check_mysql
RUN mkdir /opt/check_mysql
COPY check_mysql.tar.gz /opt/check_mysql/
RUN cd /opt/check_mysql/ && tar zxvf check_mysql.tar.gz
RUN cd /opt/check_mysql/check_mysql_health-2.2.2 && ./configure && make && make install

# Copy custom config files
COPY /config/commands.cfg /opt/nagios/etc/objects/
COPY /config/flights.cfg /opt/nagios/etc/objects/
COPY /config/nagios.cfg /opt/nagios/etc/

## SSH config
COPY /config/config /opt/nagios/.ssh/
COPY /config/config /opt/nagios/.ssh/config
RUN su nagios
RUN ssh-keygen -t rsa -b 4096 -f /opt/nagios/.ssh/id_rsa
RUN ssh-copy-id -i /opt/nagios/.ssh/id_rsa.pub nagios@169.254.62.230

