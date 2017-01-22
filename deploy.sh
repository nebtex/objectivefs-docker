#!/usr/bin/env bash

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

if command_exists docker-compose;then
    echo "docker-compose is installed already"
else
    curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

mkdir /nebtex/genos
mount --bind /nebtex/genos /nebtex/genos
mount --make-shared /nebtex/genos