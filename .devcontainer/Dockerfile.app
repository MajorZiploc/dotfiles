# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.177.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# Install just command runner
COPY ./utils/install-just.sh install-just.sh
RUN bash ./install-just.sh

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
     && apt-get -y install --no-install-recommends vim neovim tmux npm wget zsh

# Install powershell core
RUN apt-get -y install --no-install-recommends apt-transport-https software-properties-common \
     && wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb \
     && dpkg -i packages-microsoft-prod.deb \
     && apt-get update \
     && add-apt-repository universe \
     && apt-get install -y --no-install-recommends powershell

