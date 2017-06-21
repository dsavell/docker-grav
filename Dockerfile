FROM centos:latest

MAINTAINER David Savell <dsavell21@gmail.com>

RUN yum -y update
RUN yum -y install httpd
RUN yum -y install epel-release
RUN yum -y install nano wget unzip git
RUN yum -y update
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum clean all
RUN yum -y install php70w php70w-curl php70w-openssl php70w-zip php70w-pecl-apcu php70w-gd php70w-mysql php70w-xml php70w-mbstring php70w-opcache
RUN sed -i '151s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
RUN systemctl enable httpd
RUN git clone -b master https://github.com/getgrav/grav.git /var/www/html
RUN cd /var/www/html && bin/grav install
RUN cd /var/www/html && bin/gpm install admin
RUN cd /var/www/html && bin/gpm selfupgrade
RUN cd /var/www/html && bin/gpm update
RUN chown -R apache:apache /var/www/html

VOLUME /var/www/html

EXPOSE 80

ENTRYPOINT httpd -D FOREGROUND
