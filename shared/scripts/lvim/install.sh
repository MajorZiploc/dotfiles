LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh)

echo "PUT THIS IN YOUR PATH via ~/.zshrc_ext and ~/.bashrc_ext:"
echo 'export PATH="/Users/<user_name>/.local/bin:$PATH"'

echo "To uninstall lunar vim:"
echo "bash ~/.local/share/lunarvim/lvim/utils/installer/uninstall.sh"

