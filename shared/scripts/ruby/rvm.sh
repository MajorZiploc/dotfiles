#!/bin/sh

rvm install 3.1.0;
rvm alias create default 3.1.0;
rvm docs generate-ri;
gem i solargraph;

