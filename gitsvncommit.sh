#!/bin/bash

. ~/bin/gitmerge.sh

#$GIT svn dcommit -A ~/.authors-transform.txt && \
$GIT svn dcommit && \
$GIT checkout $BRANCH && \
$GIT rebase $MASTER && \
$GIT stash pop || exit 3

echo
echo "SVN commit do branch $BRANCH no $MASTER realizado com sucesso."
echo

