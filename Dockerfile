FROM mono:4.6.1.3
MAINTAINER Guilherme Barros <guilherme@tecsoft.info>
ENV WKHTMLTOPDF_BIN "/usr/local/bin"
WORKDIR /tmp
 
RUN echo "deb http://httpredir.debian.org/debian wheezy main contrib" > /etc/apt/sources.list \
 && echo "deb http://security.debian.org/ wheezy/updates main contrib" >> /etc/apt/sources.list \
 && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
 && apt-get update \
 && apt-get install -y ttf-mscorefonts-installer xz-utils wget gdebi

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.2.1/wkhtmltox-0.12.2.1_linux-wheezy-amd64.deb \
 && gdebi --n wkhtmltox-0.12.2.1_linux-wheezy-amd64.deb \
 && chmod +x /usr/local/bin/wkhtmltopdf

RUN apt-get -y remove --purge wget xz-utils gdebi \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* /tmp/*
