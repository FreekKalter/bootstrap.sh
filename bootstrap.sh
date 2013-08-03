#!/bin/bash

# $1 is project/dir name
# $2 is optional language
if [ -z $1 ]; then
    exit
fi
DESTINATION=$1
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LANG=$2

mkdir $DESTINATION

echo $DESTINATION
echo $SCRIPT_DIR

cd $DESTINATION
# call git init
git init
cd $SCRIPT_DIR

# Create gitignore
echo "\
.*.sw[a-z]
tags\
" > $DESTINATION/.gitignore

# set up hooks for ctag generation
# https://github.com/lyosha/ctags-go/blob/master/FAQ
#echo "\
##!/bin/sh
#cd $DESTINATION
#ctags *
#find * -type d -prune -print | ctags -aR --file-scope=no -L" > $DESTINATION/.git/hooks/dirtags

#echo "\
##!/bin/sh
#cd $GIT_DIR/..
#echo `pwd`
#find * -type d -exec dirtags {} \; " > $DESTINATION/.git/hooks/post-commit

#chmod +x $DESTINATION/.git/hooks/dirtags
#chmod +x $DESTINATION/.git/hooks/post-commit
#cp $DESTINATION/.git/hooks/post-commit $DESTINATION/.git/hooks/post-merge


# Setup Pre-commit-hooks
bash $SCRIPT_DIR/Pre-commit-hooks/install_hooks.sh $DESTINATION

# set up License file
cp LICENSE $DESTINATION

git add .

git commit -m 'first'

case "$LANG" in
"go")
    echo "Go"
;;
"shell")
    echo "shell"
;;
esac

