#!/bin/bash

# tutorial (using Python): https://dbader.org/blog/how-to-make-command-line-commands-with-python
# tutorial using Python and Click package: https://dbader.org/blog/python-commandline-tools-with-click
# more info on creating shell commands using Python (particularly see 'Entry Point Basics' section, which could be seen as adding to a setup.py as an alternative to my shell script below): https://realpython.com/comparing-python-command-line-parsing-libraries-argparse-docopt-click/

reponame=$1
commandname=$2

if [ -z "$commandname" ]; then
    echo "exiting: no command name was specified (second argument)"
    exit
fi

entrypoint=$reponame/main.py

userhomebindir=~/bin  # use a bin directory in the user's home, not in the system home to avoid potential conflicts
hiddenuserhomebindir=~/.bin

if [[ ! -d "$userhomebindir" ]]; then
    echo "creating a bin directory in the user home: $userhomebindir"
    mkdir -p $userhomebindir

    if [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
        echo "path to bin dircectory already present, so will not be added"
    else
        if grep -Fxq 'export PATH=$PATH":$HOME/bin"' ~/.bashrc; then
            echo "export for path directory already found in ~/.bashrc file, so will not be added"
        else
            echo "adding user home bin directory to PATH (using the ~/.bashrc file)"
            echo 'export PATH=$PATH":$HOME/bin"' >> ~/.bashrc
        fi
    fi
fi

echo "copying entrypoint file ($entrypoint) to user home bin directory ($userhomebindir) with command name $commandname"
cp $entrypoint $userhomebindir/$commandname

if [[ ! -d "$hiddenuserhomebindir" ]]; then
    echo "creating a hidden bin directory in the user home: $hiddenuserhomebindir"
    mkdir $hiddenuserhomebindir
fi

echo "copying directory ($reponame) to hidden user bin directory ($hiddenuserhomebindir)"
cp -r $reponame $hiddenuserhomebindir/

echo "creating a Python 3.7 virtual environment for the command in the copied directory ($hiddenuserhomebindir/$reponame) as 'env'"
virtualenv -p python3.7 $hiddenuserhomebindir/$reponame/env
if [[ -f "$hiddenuserhomebindir/$reponame/requirements.txt" ]]; then
    echo "installing requirements into the new virtual environment"
    source $hiddenuserhomebindir/$reponame/env/bin/activate && pip3 install -r $hiddenuserhomebindir/$reponame/requirements.txt
fi

echo "setting shebang in copied entrypoint file ($commandname) to be the copied virtual env"
sed -i "1i#!$hiddenuserhomebindir/$reponame/env/bin/python" $userhomebindir/$commandname

echo "adding path to copied directory in the copied entrypoint file ($commandname)"
sed -i "2iimport sys" $userhomebindir/$commandname
sed -i "3ifrom pathlib import Path" $userhomebindir/$commandname
sed -i "4imodule_path = str(Path('$hiddenuserhomebindir/$reponame'))" $userhomebindir/$commandname
sed -i "5iif module_path not in sys.path:" $userhomebindir/$commandname
sed -i "6i\ \ \ \ sys.path.append(module_path)  # e.g. '.../repos/<name_of_this_repo>'" $userhomebindir/$commandname

echo "marking copied entrypoint file ($commandname) as executable"
chmod +x $userhomebindir/$commandname

