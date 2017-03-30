FROM ubuntu:16.04
MAINTAINER Manuel Gauto <mgauto@mgenterprises.org>

#Keep APT quiet
ENV DEBIAN_FRONTEND noninteractive

#Pull down package list
RUN apt-get update

#Install wget and ca-certificates
RUN apt-get -y install wget ca-certificates

#Install Puppet
RUN wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
RUN dpkg -i puppetlabs-release-pc1-xenial.deb

#Add the Foreman repos
RUN echo "deb http://deb.theforeman.org/ xenial 1.14" > /etc/apt/sources.list.d/foreman.list
RUN echo "deb http://deb.theforeman.org/ plugins 1.14" >> /etc/apt/sources.list.d/foreman.list
RUN wget -q https://deb.theforeman.org/pubkey.gpg -O- | apt-key add -

#Update apt
RUN apt-get update

#Install the Foreman Installer
RUN apt-get -y install foreman-installer

#Install cleanup after ourselves
RUN apt-get -y clean

#Copy run script
COPY run-foreman.sh /usr/bin/run-foreman.sh
RUN chmod +x /usr/bin/run-foreman.sh

#Generate Locale
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
RUN locale-gen

#Install foreman
CMD /usr/bin/run-foreman.sh
