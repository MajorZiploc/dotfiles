# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# . /opt/homebrew/etc/bash_completion.d/docker
. /opt/homebrew/etc/bash_completion.d/just
. /opt/homebrew/etc/bash_completion.d/brew
. /opt/homebrew/etc/bash_completion.d/bash-builtins
. /opt/homebrew/etc/bash_completion.d/nvm
. /opt/homebrew/etc/bash_completion.d/tmux
. /opt/homebrew/etc/bash_completion.d/rg.bash
# . /opt/homebrew/etc/bash_completion.d/npm
. /opt/homebrew/etc/bash_completion.d/asdf.bash

eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR=~/.nvm
. "$(brew --prefix nvm)/nvm.sh"
export PATH="/opt/homebrew/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"

# for v11
# export MY_JAVA_VERSION="@11";
# for v17
export MY_JAVA_VERSION="@17";
# for latest
# export MY_JAVA_VERSION="";
export PATH="/opt/homebrew/opt/openjdk${MY_JAVA_VERSION}/bin:$PATH"
# For compilers to find openjdk you may need to set:
# export CPPFLAGS="-I/opt/homebrew/opt/openjdk${MY_JAVA_VERSION}/include"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"
[[ -d $HOME/.cargo ]] && . $HOME/.cargo/env

# golang
# [[ -e $HOME/.gvm/scripts/gvm ]] && . ~/.gvm/scripts/gvm;

# ruby - the default location if not using rvm
# export GEM_HOME="$HOME/.gem";

# ruby - rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# adds python version manager to path
export PATH="$(pyenv root)/shims:$PATH";
