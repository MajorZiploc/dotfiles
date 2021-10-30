# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

ssh-keygen # -t ed25519 -C "todo@todo.net"

eval "$(ssh-agent -s)"

ssh-add # ~/.ssh/id_ed25519

# test ssh connection to github
# ssh -T git@github.com

