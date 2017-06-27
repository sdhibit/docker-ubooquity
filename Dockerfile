FROM sdhibit/openjdk:8-jre
MAINTAINER Steve Hibit <sdhibit@gmail.com>

RUN addgroup -S ubooquity \
 && adduser -SHG ubooquity ubooquity

# Install apk packages
RUN apk --update upgrade \
 && apk --no-cache add \
  unzip \
  wget 

# Set Ubooquity Package Information
ENV PKG_NAME ubooquity
ENV PKG_VER 1.10.1
ENV APP_BASEURL http://vaemendis.net/ubooquity/downloads
ENV APP_PKGNAME Ubooquity-${PKG_VER}.zip
ENV APP_URL ${APP_BASEURL}/${APP_PKGNAME}
ENV APP_PATH /opt/ubooquity

# Download & Install Ubooquity
RUN mkdir -p "${APP_PATH}" \
 && wget -O "${APP_PATH}/ubooquity.zip" ${APP_URL} \
 && unzip "${APP_PATH}/ubooquity.zip" -d ${APP_PATH} \
 && rm "${APP_PATH}/ubooquity.zip" 

# Create config and change ownership
RUN mkdir /config \
 && chown -R ubooquity:ubooquity \
    ${APP_PATH} \
    "/config"

VOLUME ["/config"]

# HTTP ports
EXPOSE 2202

WORKDIR /config

# Add services to runit
ADD ubooquity.sh /etc/service/ubooquity/run
RUN chmod +x /etc/service/*/run
