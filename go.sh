#!/bin/bash
BOTFILE=$1
GITBRANCH=$2
GITREPO=$3
if [ -d .git ]; then
    if [ -f .git/config ]; then
        ORIGIN=$(git config --get remote.origin.url)
        if [ ! -z "${ORIGIN}" ]; then
            echo ".git config detected. Pulling from '${ORIGIN}'..."
            git pull
        fi
    fi
elif [ ! -z ${GITREPO} ]; then
    if [[ ${GITREPO} != *.git ]]; then
        GITREPO=${GITREPO}.git
    fi
    echo -e "By cloning a Git repo, all existing files will be deleted. Continue? [Enter yes or no]"
    read confirm
    case $confirm in
        [Yy]* )
            rm *
            echo -e "/home/container is now empty. Cloning '${GITBRANCH}' from '${GITREPO}'..."
            git clone --single-branch --branch ${GITBRANCH} ${GITREPO} .
            echo -e "Finished cloning '${GITBRANCH}' from '${GITREPO}' into /home/container!"
            ;;
        * ) echo "Exiting script..."; exit;;
    esac
fi
echo 'Bot starting in 5 seconds...'
chmod +x ./${BOTFILE}
./${BOTFILE}
