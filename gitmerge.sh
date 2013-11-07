#!/bin/bash

BRANCH=$(git branch | grep '*' | cut -d ' ' -f 2)
MASTER=master

[ "$BRANCH" == "frac" ] && MASTER=fracionada
[ ! -z "$1" ] && MASTER=$1

[ "$BRANCH" = $MASTER ] && echo "Impossivel executar o $(basename $0) a partir do branch $MASTER" && exit 1

echo "Fazendo o svn merge do $BRANCH no $MASTER, continuar? (s/n)"
read resp
[ "$resp" == "s" ] || exit 1
echo "continuando..."

GIT=git

$GIT stash
$GIT checkout $MASTER                          && \
#$GIT svn rebase -A ~/.authors-transform.txt && \
$GIT svn rebase && \
$GIT checkout $BRANCH                          && \
$GIT rebase $MASTER                            && \
$GIT checkout $MASTER                          && \
$GIT merge --ff $BRANCH                        || exit 2

echo "Pronto para o git svn dcommit"
echo

