# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.177.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
# TODO: consider a different ubuntu base image, this one appears to be really slow
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

COPY . /home-settings

# TODO: reverify this one after having removed sudos in slim install
RUN /home-settings/setup/ubuntu-slim-container/scripts/install.sh

# TODO: reverify this one
RUN /home-settings/setup/ubuntu-slim-container/scripts/vim/set_shells.sh

# RUN /home-settings/shared/scripts/nodejs/nvm_install_lts.sh

# RUN /home-settings/setup/ubuntu/scripts/copy.sh 111

CMD ["sleep", "infinity"]
