# echos each file/folder recursively
find . -name '*' -exec echo {} \;


# delete all mp3 files in folder
find . -type f -name '*.mp3' -exec rm -f {} \;

# find all empty directories in folder
find . -type d -empty

# rename files that match *hid* recursively, need to test more to see how it behaves
# Maybe? after the rename occurs,
# the new filename can also matches the pattern. Might not be what you want
find . -name '*hid*' -exec mv {} {}_renamed \;
# seems to work better than the previous
find . -type d -name '*hid*' -print0 | xargs --null -I{} mv {} {}_renamed
# even better?
find . -name '*hid*' -printf "%f\0" | xargs --null -I{} mv {} "prefix {} suffix"
find . -type f -name 'file*' -execdir mv {} {}_renamed ';'
# okdir will do the changes interactively and ask if you want to perform the exec
find . -type f -name 'file*' -okdir mv {} {}_renamed ';'
for i in $(find . -name '*'); do echo $i $i.bak; done

# bash one liner to find directories that match a list of patterns
l=('.setup*' 'delete*'); for p in ${l[@]}; do find . -type d -name "$p" -print0 | xargs --null -I{} echo {}; done

