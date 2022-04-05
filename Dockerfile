FROM ubuntu:20.04

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

RUN apt-get -qq update && apt-get -qq install -y aria2 curl unzip 

RUN curl https://rclone.org/install.sh | bash

COPY . .
RUN chmod +x on_download_complete.sh startup.sh

CMD ["bash", "startup.sh"]