# Remove duplicate entries from PATH. Keeping first occurence, this works, just likely not worth the on start impact for bash
# export PATH=$(echo -n $PATH | awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}')

