FROM centos:6

# Set variables
ENV rt_perl_version 5.22.0
ENV rt_version 4.2.12

# Update the system
RUN yum update -y

# Install Dependences
RUN yum install -y perl tar bzip2 gcc wget gd-devel graphviz-devel expat-devel postgresql-devel

# Install PerlBrew
RUN mkdir -p /opt/rt_perl
ENV PERLBREW_ROOT=/opt/rt_perl
RUN curl -L http://install.perlbrew.pl | bash

# Install RT's Perl
RUN /opt/rt_perl/bin/perlbrew install perl-${rt_perl_version}
ENV PATH /opt/rt_perl/perls/perl-${rt_perl_version}/bin:${PATH}

# Install cpanminus
RUN wget -q -O - https://cpanmin.us | /opt/rt_perl/perls/perl-${rt_perl_version}/bin/perl - App::cpanminus

# Install RT
ENV RT_FIX_DEPS_CMD /opt/rt_perl/perls/perl-${rt_perl_version}/bin/cpanm
RUN cd /root
RUN curl -O https://download.bestpractical.com/pub/rt/release/rt-${rt_version}.tar.gz
RUN tar xzf rt-${rt_version}.tar.gz
RUN cd rt-${rt_version}
RUN /rt-${rt_version}/configure --enable-graphviz --enable-gd --with-db-type=Pg --with-web-user=apache --with-web-group=apache
RUN make fixdeps
