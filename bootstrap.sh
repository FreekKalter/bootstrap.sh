#!/bin/bash

# $1 is project/dir name
# $2 is optional language
if [ -z $1 ]; then
    exit
fi
DESTINATION=$1
HOOK_DEST=$DESTINATION/.git/hooks
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LANG=$2

mkdir $DESTINATION
cd $DESTINATION

# call git init
git init
cd $SCRIPT_DIR

# Create gitignore
echo "\
.*.sw[a-z]
tags\
" > $DESTINATION/.gitignore

echo "\
# $DESTINATION" >$DESTINATION/README.md

# set up hooks for ctag generation
# https://github.com/lyosha/ctags-go/blob/master/FAQ
echo "\
#!/bin/sh
cd $1
ctags *
find * -type d -prune -print | ctags -aR --file-scope=no -L" > $HOOK_DEST/dirtags

echo "\
#!/bin/sh
cd \$GIT_DIR/..
echo `pwd`
find * -type d -exec .git/hooks/dirtags {} \; " > $HOOK_DEST/post-commit

chmod +x $HOOK_DEST/dirtags
chmod +x $HOOK_DEST/post-commit
cp $HOOK_DEST/post-commit $HOOK_DEST/post-merge

# Setup Pre-commit-hooks
cp pre-commit $HOOK_DEST
cp pre-commit-default $HOOK_DEST

# set up License file
cp LICENSE $DESTINATION

case "$LANG" in
"go")
    echo "Go"
    cp gofmt-git-hook/fmt-check $HOOK_DEST/pre-commit-gofmt
;;
"shell")
    echo "shell"
;;
esac

cd $DESTINATION
git add "."
git commit -m 'first'
