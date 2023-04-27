FROM alpine:latest

WORKDIR /app

ENV TZ=Asia/Kolkata

RUN apk add --no-cache bash aria2 curl unzip && \
curl https://rclone.org/install.sh | bash && \
rm -rf /var/cache/apk/*

COPY on_download_complete.sh on_download_complete.sh
COPY startup.sh startup.sh

RUN chmod +x on_download_complete.sh startup.sh

CMD ["bash", "startup.sh"]