#!/bin/bash

gitusername=$@

if [[ -z "${githubname// }" ]]
then
    echo "exiting (sanity check failed): no GitHub username given"
    exit
fi

#defaultprojectsroot=~/python_projects
projectsroot=$PWD
echo "project root set to $projectsroot"

if [[ ! -d "$projectsroot/repos" ]]
then
    echo "exiting (safety check failed): no repos directory found in project root directory; please create one first using 'mkdir repos'"
    exit
fi

gitapicall=$(curl https://api.github.com/users/$gitusername/repos?per_page=1000)  # note: restriction on number of pages is a sanity check

for repoinfo in $(echo "${gitapicall}" | jq -c '.[]')
do
    if echo $repoinfo | jq -r '.html_url' 2>/dev/null  # check for json type
    then
        if echo $repoinfo | jq -e 'has("html_url")' > /dev/null  # check if required field is present, and suppress resulting true/false output
        then
            repourl=$(echo $repoinfo | jq -r '.html_url')
            if [[ -z "${repourl// }" ]]
            then
		echo "skipping over item due to empty html_url $repourl"
                continue
            fi

            reponame=$(echo $repoinfo | jq -r '.name')
            echo "found $reponame"

	    if [[ -d "$projectsroot/repos/$reponame" ]]
            then
                echo "$reponame already exists, nothing to be done"
		continue
            fi

            echo "cloning $reponame"
	    cd $projectsroot/repos/ && git clone $repourl
        fi
    fi
done
