#!/usr/bin/env bash

# this may be required in order to fix ionide intellisense
# changes the version of .net sdk that fsac is using

# change dotnet 5.0 to dotnet 6.0
sed -E -i'' 's,5,6,g' ~/.vim/plugged/Ionide-vim/fsac/fsautocomplete.runtimeconfig.json;

# TODO: should be placed in some sort of user config rather than changing the above file
# https://github.com/fsharp/FsAutoComplete#building-and-testing

