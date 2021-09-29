# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return;;
esac

test -f ~/.bashrc && . ~/.bashrc

