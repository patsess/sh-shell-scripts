#!/bin/bash

# tutorial: https://dbader.org/blog/how-to-make-command-line-commands-with-python

filename=$@
userhomebindir=~/bin  # use a bin directory in the user's home, not in the system home to avoid potential conflicts

echo "checking for interpreter shebang"
if [[ $(head -n 1 $filename | cut -c 1-2) != "#!" ]]
then
    echo "exiting: interpreter shebang (e.g. '#!/bin/bash' for a .sh file) could not be found"
    exit
fi

#echo "marking file as executable"
#chmod +x $filename

if [[ ! -d "$projectsroot" ]]
then
    echo "creating a bin directory in the user home: $userhomebindir"
    mkdir -p $userhomebindir

    echo "adding user home bin directory to PATH"
    echo 'export PATH=$PATH":$HOME/bin"' >> ~/.profile
fi

echo "copying file to user home bin directory ($userhomebindir)"
cp $filename $userhomebindir

echo "marking copied file as executable"
chmod +x $userhomebindir/$filename
