# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

ssh-keygen -t ed25519 -C "lakemonyew@gmail.com"

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_ed25519

