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
RUN apt-get update
RUN apt-get install sshpass
RUN su nagios
RUN ssh-keygen -t rsa -b 4096 -f /opt/nagios/.ssh/id_rsa
#RUN echo "Host *" > /opt/nagios/.ssh/config && echo " StrictHostKeyChecking no" >> /opt/nagios/.ssh/config
#RUN ssh-keyscan -H -t rsa 169.254.62.230  >> /opt/nagios/.ssh/known_hosts
RUN sshpass -p nagios ssh-copy-id -o StrictHostKeyChecking=no -i /opt/nagios/.ssh/id_rsa.pub nagios@169.254.62.230

