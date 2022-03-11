#!/usr/bin/env bash

sudo sed -E -i'' '/# do not bell on tab/d' /etc/inputrc;
sudo sed -E -i'' '/set bell-style/d' /etc/inputrc;

sudo printf "# do not bell on tab-completion\nset bell-style none\nset bell-style visible\n" >> /etc/inputrc;

