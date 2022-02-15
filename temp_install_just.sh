#!/usr/bin/env bash

dest="/usr/local/bin"
td=$(mktemp -d || mktemp -d -t tmp)
curl -0Lks "https://github.com/casey/just/releases/download/0.11.0/just-0.11.0-x86_64-unknown-linux-musl.tar.gz" | tar -C $td -xz

for f in $(ls $td); do
  test -x $td/$f || continue

  if [ -e "$dest/$f" ] && [ $force = false ]; then
    err "$f already exists in $dest"
  else
    mkdir -p $dest
    install -m 755 $td/$f $dest
  fi
done
rm -rf $td
