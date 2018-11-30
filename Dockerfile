FROM mono:4.6.1.3
WORKDIR /tmp
ENV WKHTMLTOPDF_BIN "/usr/bin"
RUN echo "deb http://httpredir.debian.org/debian jessie main contrib" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib" >> /etc/apt/sources.list \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get update
RUN apt-get install -y ttf-mscorefonts-installer xz-utils wget libxext6
RUN wget http://http.us.debian.org/debian/pool/main/libj/libjpeg-turbo/libjpeg62-turbo_1.3.1-12_amd64.deb \
    && apt-get install -f -y ./libjpeg62-turbo_1.3.1-12_amd64.deb \
    && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.jessie_amd64.deb \
    && apt-get install -f -y ./wkhtmltox_0.12.5-1.jessie_amd64.deb \
    && mv wkhtmltox/bin/wkhtmlto* /usr/bin/ \
    && apt-get -y remove --purge wget xz-utils apt \ 
    && apt-get clean \ 
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/*
WORKDIR /