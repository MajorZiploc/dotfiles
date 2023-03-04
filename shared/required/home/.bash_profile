# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return;;
esac

test -e ~/.bashrc && . ~/.bashrc >/dev/null 2>&1;

