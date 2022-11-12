#!/bin/sh

rbenv install 3.1.2;
rbenv global 3.1.2;
gem i solargraph;
echo "ruby version is now: `ruby -v`"
gem update --system;
gem install rails;

