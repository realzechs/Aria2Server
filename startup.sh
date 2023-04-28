#!/bin/bash

# Create download folder & zplex folder
mkdir -p /app/aria2
mkdir -p ~/.config/rclone

# Creating rclone config file
if [[ -n "$RCLONE_ACCOUNT" ]]; then
    echo "[ INFO ] Downloading rclone service account"
    curl -s -o /app/rclone.conf "$RCLONE_ACCOUNT"
fi

if [[ -n "$TEAM_DRIVE_ID" ]]; then
    if [[ -f "/app/rclone.conf" ]]; then
        echo "[ INFO ] rclone.json found, making rclone config"
        echo """[upload]
type = drive
scope = drive
service_account_file = /app/rclone.json
team_drive = ${TEAM_DRIVE_ID}
""" >>~/.config/rclone/rclone.conf
    else
        echo "[ INFO ] RCLONE_ACCOUNT not set, skipping making rclone config"
    fi
else
    echo "[ INFO ] TEAM_DRIVE_ID is not set, skipping making rclone config"
fi


# Starting Rclone RC Server
rclone rcd --rc-no-auth --drive-server-side-across-configs \
    --rc-job-expire-interval=86400s --rc-job-expire-duration=86400s &

# Aria2 RPC Server for downloading
aria2c --enable-rpc --rpc-listen-all=true --rpc-listen-port ${PORT:-5000} \
    --max-connection-per-server=10 --continue=true --split=10 --rpc-allow-origin-all \
    --rpc-save-upload-metadata=false --rpc-max-request-size=1024M --follow-torrent=mem \
    --allow-overwrite=true --max-concurrent-downloads=5 --seed-time=0 --bt-seed-unverified=true \
    --bt-max-peers=0 --bt-tracker-connect-timeout=10 --bt-tracker-timeout=10 \
    --user-agent='qBittorrent v4.3.3' --peer-agent='qBittorrent v4.3.3' --peer-id-prefix=-qB4330- \
    --on-download-complete=/app/on_download_complete.sh --dir=/app/aria2
