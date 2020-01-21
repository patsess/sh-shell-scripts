#!/bin/bash

# DESCRIPTION:
# This script will set up (create and/or update) Python virtual environments for repos in a directory using the structure of having a 'repos' directory and an 'envs' directory within a directory of projects, e.g. ~/python_projects/repos/... and ~/python_projects/envs/... for a directory '~/python_projects'. The root directory must already contain the repos directory, and the root directory can be specified using the only argument of the script, or it will default to the current working directory. A virtual environment is only created/updated for a repo if there is a 'requirements.txt' file found in the highest level of the repo.

# note: if I start using subdirectories to group repos, then I could look at using the "find" shell function to find any requirements.txt files. Or, and perhaps better, would be to reserve the 'python_projects' directory for repos that can all sit together on one level, and to modify this script to take the directory as an input (and can default to current working directory) and then it can be used for any directory of repos, e.g. a 'companyX' directory etc.

echo "updating pip"
pip3 install --upgrade pip

#defaultprojectsroot=~/python_projects
defaultprojectsroot=$PWD
projectsroot=${@:-$defaultprojectsroot}
echo "project root set to $projectsroot"

if [[ ! -d "$projectsroot/repos" ]]
then
    echo "exiting: no repos directory found in project root directory"
    exit
fi

reponames=($projectsroot/repos/*/)
#echo "${reponames[@]}"

for reponame in "${reponames[@]}"
do
    reponame="$(basename -- $reponame)"
    
    echo "starting $reponame"
    requirementspath=$projectsroot/repos/$reponame/requirements.txt
    envpath=$projectsroot/envs/$reponame
    
    if [[ -f "$requirementspath" ]]
    then
        if [[ ! -d "$projectsroot/envs" ]]
        then
            echo "creating a directory for envs"
            mkdir $projectsroot/envs
        fi
        
        if [[ ! -d "$envpath" ]]
        then
            echo "[$reponame] creating virtualenv"
            virtualenv -p python3.7 $envpath
        fi
        
        echo "[$reponame] installing requirements"
        source $envpath/bin/activate && \
            pip3 install -r $requirementspath && \
            deactivate
    else
        echo "[$reponame] no requirements file found"
    fi
    
    echo "finished $reponame"
    echo "******************************"
done

