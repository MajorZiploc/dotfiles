# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return;;
esac

test -f ~/.zshrc_core && . ~/.zshrc_core

