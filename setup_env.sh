#!/usr/bin/env bash
set -ex

apt-get update
apt-get upgrade -y
apt-get install -y --no-install-recommends \
    git \
    curl \
    rsync \
    psmisc \
    xfconf
apt-get clean
rm -rf /var/lib/apt/lists/*