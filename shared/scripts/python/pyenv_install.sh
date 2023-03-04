. ~/.bashrc 2>/dev/null;

function main {
  local python_version='3.11.2';
  pyenv install "$python_version";
  pyenv global "$python_version";
  pip install --upgrade pip;
}

main
