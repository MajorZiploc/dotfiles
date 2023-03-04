# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return;;
esac

test -e ~/.zshrc_core && . ~/.zshrc_core >/dev/null 2>&1;

