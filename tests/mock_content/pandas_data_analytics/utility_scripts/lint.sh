#!/bin/sh

echo "Linting project..."

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# find "$SCRIPTPATH" -regextype egrep -iregex ".*\.py" -type f -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' -exec autopep8 --in-place --aggressive --aggressive "{}" \; 
autopep8 "$SCRIPTPATH/.." && echo "Projected Linted!" || { echo "Failed to lint project!"; exit 1; }

