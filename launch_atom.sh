#!/bin/bash

# note: to create a new Atom config, lauch Atom with the default config, install packages, then cut the .atom directory elsewhere (e.g. into the ~/atom_setups/ directory to use this script)

atomhomes=(~/atom_homes/*/)
#defaultatomhome=~/.atom
wantedhome=~/atom_homes/$@/

foundhome=0  # initialise
for atomhome in "${atomhomes[@]}"
do
    if [[ "$atomhome" == "$wantedhome" ]]
    then
        foundhome=1  # over-write
        atomhome="$atomhome"
        echo "launching Atom with $atomhome as ATOM_HOME"
        ATOM_HOME=$atomhome /usr/bin/atom
        break
    fi
done

if [[ $foundhome == 0 ]]
then
    echo "Atom home not found, please try again, e.g. bash launch_atom python"
    echo "avaiable Atom homes can be found at: ${atomhomes[@]}"
fi
