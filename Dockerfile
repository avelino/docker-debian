FROM debian:stable  
MAINTAINER Thiago Avelino <thiago@avelino.xxx>

# upgrade distro
RUN aptitude update
RUN aptitude upgrade -y
RUN aptitude install -y postfix openssh-server supervisor 

# clean packages
RUN aptitude clean

# make /var/run/sshd
RUN mkdir /var/run/sshd

# copy supervisor conf
ADD sshd.conf /etc/supervisor/conf.d/sshd.conf

# expose ssh port
EXPOSE 22

# start supervisor
CMD ["/usr/bin/supervisord"]
