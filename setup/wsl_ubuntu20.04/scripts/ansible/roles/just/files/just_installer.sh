#!/usr/bin/env bash

set -eu pipefail

if [ ! -z ${GITHUB_ACTIONS-} ]; then
  set -x
fi

git=casey/just
crate=just
url=https://github.com/casey/just
releases=$url/releases

say() {
  echo "install: $@"
}

say_err() {
  say "$@" >&2
}

err() {
  if [ ! -z ${td-} ]; then
    rm -rf $td
  fi

  say_err "error: $@"
  exit 1
}

need() {
  if ! command -v $1 > /dev/null 2>&1; then
    err "need $1 (command not found)"
  fi
}

force=false
while test $# -gt 0; do
  case $1 in
    --force | -f)
      force=true
      ;;
    --tag)
      tag=$2
      shift
      ;;
    --target)
      target=$2
      shift
      ;;
    --to)
      dest=$2
      shift
      ;;
    *)
      ;;
  esac
  shift
done

# Dependencies
need basename
need curl
need install
need mkdir
need mktemp
need tar

# Optional dependencies
if [ -z ${tag-} ]; then
  need cut
  need rev
fi

if [ -z ${dest-} ]; then
  dest="/usr/local/bin"
fi

if [ -z ${tag-} ]; then
  tag=$(curl -s "$releases/latest" | cut -d'"' -f2 | rev | cut -d'/' -f1 | rev)
fi

if [ -z ${target-} ]; then
  uname_target=`uname -m`-`uname -s`

  case $uname_target in
    aarch64-Linux)     target=aarch64-unknown-linux-gnu;;
    x86_64-Darwin)     target=x86_64-apple-darwin;;
    x86_64-Linux)      target=x86_64-unknown-linux-musl;;
    x86_64-Windows_NT) target=x86_64-pc-windows-msvc;;
    *)
      err 'Could not determine target from output of `uname -m`-`uname -s`, please use `--target`:' $uname_target
    ;;
  esac
fi

archive="$releases/download/$tag/$crate-$tag-$target.tar.gz"

say_err "Repository:  $url"
say_err "Crate:       $crate"
say_err "Tag:         $tag"
say_err "Target:      $target"
say_err "Destination: $dest"
say_err "Archive:     $archive"

td=$(mktemp -d || mktemp -d -t tmp)
curl -0Lks $archive | tar -C $td -xz

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
