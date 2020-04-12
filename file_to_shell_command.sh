#!/bin/bash

# tutorial (using Python): https://dbader.org/blog/how-to-make-command-line-commands-with-python
# tutorial using Python and Click package: https://dbader.org/blog/python-commandline-tools-with-click
# more info on creating shell commands using Python (particularly see 'Entry Point Basics' section): https://realpython.com/comparing-python-command-line-parsing-libraries-argparse-docopt-click/

filename=$@

commandname="${filename%.*}"  # without the file extension
commandname="${commandname//[_]/-}"

userhomebindir=~/bin  # use a bin directory in the user's home, not in the system home to avoid potential conflicts

echo "checking for interpreter shebang"
if [[ $(head -n 1 $filename | cut -c 1-2) != "#!" ]]
then
    echo "exiting: interpreter shebang (e.g. '#!/bin/bash' for a .sh file) could not be found"
    exit
fi

if [[ ! -d "$userhomebindir" ]]
then
    echo "creating a bin directory in the user home: $userhomebindir"
    mkdir -p $userhomebindir

    if [[ ":$PATH:" == *":$HOME/bin:"* ]]
    then
        echo "path to bin dircectory already present, so will not be added"
    else
        if grep -Fxq 'export PATH=$PATH":$HOME/bin"' ~/.bashrc
        then
            echo "export for path directory already found in ~/.bashrc file, so will not be added"
        else
            echo "adding user home bin directory to PATH (using the ~/.bashrc file)"
            echo 'export PATH=$PATH":$HOME/bin"' >> ~/.bashrc
        fi
    fi
fi

echo "copying file to user home bin directory ($userhomebindir) with command name $commandname"
cp $filename $userhomebindir/$commandname

echo "marking copied file ($commandname) as executable"
chmod +x $userhomebindir/$commandname
