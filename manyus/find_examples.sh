# echos each file/folder recursively
find . -name '*' -exec echo {} \;

# delete all mp3 files in folder
find . -type f -name '*.mp3' -exec rm -f {} \;

# find all empty directories in folder
find . -type d -empty
