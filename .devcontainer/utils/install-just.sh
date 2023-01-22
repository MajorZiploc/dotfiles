#!/bin/bash

dest="/usr/local/bin"
curl -0Lk "https://github.com/casey/just/releases/download/0.10.0/just-0.10.0-x86_64-unknown-linux-musl.tar.gz" --output /tmp/just
# TODO: figure out how to only copy just to /usr/local/bin . now all content of the /tmp/just tar
tar -C /usr/local/bin -zxvf /tmp/just

chmod +755 /usr/local/bin/just

