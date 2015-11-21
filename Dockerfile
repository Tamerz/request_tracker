FROM centos:6

# Set variables
ENV rt_perl_version 5.22.0
ENV rt_version 4.2.12

# Update the system
RUN yum update -y

# Install Perl
RUN yum install -y perl tar bzip2 gcc

# Install PerlBrew
RUN mkdir -p /opt/rt_perl
ENV PERLBREW_ROOT=/opt/rt_perl
RUN curl -L http://install.perlbrew.pl | bash

# Install RT's Perl
RUN /opt/rt_perl/bin/perlbrew install perl-${rt_perl_version}

# Install RT
RUN cd ~
RUN curl -O https://download.bestpractical.com/pub/rt/release/rt-${rt_version}.tar.gz
RUN tar xzf rt-${rt_version}.tar.gz
RUN cd rt-${rt_version}

