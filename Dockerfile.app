# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.177.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

COPY . /home-settings

# RUN /home-settings/setup/ubuntu/scripts/install.sh

# RUN /home-settings/shared/scripts/vim_shell/set_shells.sh

# RUN /home-settings/shared/scripts/nodejs/nvm_install_lts.sh

# RUN /home-settings/setup/ubuntu/scripts/copy.sh 111

CMD ["sleep", "infinity"]
