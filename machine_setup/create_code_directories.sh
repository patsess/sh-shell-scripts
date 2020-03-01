#!/bin/bash

defaultprojectsroot=~/personal_projects
projectsroot=${@:-$defaultprojectsroot}
echo "project root set to $projectsroot"

codedirnames=(sh_projects tex_projects jl_projects py_projects scala_projects)
envdirnames=(py_projects)

if [[ -d "$projectsroot" ]]
then
    echo "exiting: $projectsroot directory alredy exists"
    exit
fi

echo "creating root directory for personal projects: $projectsroot"
mkdir $projectsroot

datadir=$projectsroot/data
echo "creating data directory: $datadir"
mkdir $datadir

for codedirname in "${codedirnames[@]}"
do
    codedir=$projectsroot/$codedirname
    echo "[$codedirname] creating directory: $codedir"
    mkdir $codedir

    reposdir=$codedir/repos
    envsdir=$codedir/envs

    echo "[$codedirname] creating repos directory: $reposdir"
    mkdir $reposdir

    #for nonenvname in "${nonenvnames[@]}"
    #do
    #    if [[ "$codedirname" == "$nonenvname" ]]
    #    then
    #        continue 2
    #    fi
    #done

    #echo "[$codedirname] creating directory for virtual environments: $envsdir"
    #mkdir $envsdir

    for envdirname in "${envdirnames[@]}"
    do
        if [[ "$codedirname" == "$envdirname" ]]
        then
            echo "[$codedirname] creating directory for virtual environments: $envsdir"
            mkdir $envsdir
	    break
        fi
    done
done
