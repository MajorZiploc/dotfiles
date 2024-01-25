#!/usr/bin/env bash

LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

# echo "PUT THIS IN YOUR PATH via ~/.zshrc_ext and ~/.bashrc_ext:"
# echo 'export PATH="/Users/<user_name>/.local/bin:$PATH"'

echo "To uninstall lunar vim:"
echo "bash ~/.local/share/lunarvim/lvim/utils/installer/uninstall.sh"

