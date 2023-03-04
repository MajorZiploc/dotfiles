#!/bin/sh

rbenv install 3.1.2;
rbenv global 3.1.2;
gem i solargraph;
echo "ruby version is now: `ruby -v`"
gem update --system;
# gem install rails;
# solargraph needs to be the solargraph of the ruby version you are using
# The solargraph in /usr/local/bin shadows the one we need; this one is likely the system ruby solargraph
sudo mv /usr/local/bin/solargraph /usr/local/bin/solargraph.old;

