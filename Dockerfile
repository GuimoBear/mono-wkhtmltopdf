FROM mono:4.6.1.3
WORKDIR /tmp
ENV WKHTMLTOPDF_BIN "/usr/bin"
RUN echo "deb http://httpredir.debian.org/debian jessie main contrib" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib" >> /etc/apt/sources.list \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get update \
    && apt-get install -y ttf-mscorefonts-installer xz-utils wget \
    && wget http://http.us.debian.org/debian/pool/main/libj/libjpeg-turbo/libjpeg62-turbo_1.3.1-12_amd64.deb \
    && apt install ./libjpeg62-turbo_1.3.1-12_amd64.deb \
    && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.jessie_amd64.deb \
    && apt install ./wkhtmltox_0.12.5-1.jessie_amd64.deb \
    && mv wkhtmltox/bin/wkhtmlto* /usr/bin/ \
    && apt-get install libxext-dev \
    && apt-get -y remove --purge wget xz-utils \ 
    && apt-get clean \ 
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/*
WORKDIR /