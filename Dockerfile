FROM mono:4.6.1.3
WORKDIR /tmp
ENV WKHTMLTOPDF_BIN "/usr/bin"
RUN echo "deb http://httpredir.debian.org/debian jessie main contrib" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib" >> /etc/apt/sources.list \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get update
RUN apt-get install -y ttf-mscorefonts-installer xz-utils wget
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && tar xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \ 
    && mv wkhtmltox/bin/wkhtmlto* /usr/bin/
RUN && apt-get -y remove --purge wget xz-utils \ 
    && apt-get clean \ 
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/*
WORKDIR /