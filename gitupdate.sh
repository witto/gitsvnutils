#!/bin/bash

BRANCH=$(git branch | grep '*' | cut -d ' ' -f 2)
GIT=git
MASTER=master

[ "$BRANCH" == "frac" ] && MASTER=fracionada

[ ! -z "$1" ] && MASTER=$1

echo "Fazendo o svn rebase no $MASTER, continuar?"
read resp
[ "$resp" == "s" ] || exit 1
echo "continuando..."

$GIT stash || exit
$GIT checkout $MASTER || exit
$GIT svn rebase || exit

if [ "$BRANCH" != "$MASTER" ]
then
        echo "Atualizando branch $BRANCH"
        $GIT checkout $BRANCH || exit
        $GIT rebase $MASTER || exit
fi

$GIT stash pop || exit

echo "Done"

