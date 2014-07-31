FROM debian:stable  
MAINTAINER Thiago Avelino <thiago@avelino.xxx>

# avoid debconf and initrd
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# upgrade distro
RUN locale-gen en_US en_US.UTF-8
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
