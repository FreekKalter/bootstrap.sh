# bootstrap.sh

This script will initialize a empty git dir with the following contents:

- LICENSE and README files
- a pre-commit hook wich will run all pre-commit hooks of the form pre-commit-* (*)
- pre-commit hook to check for all ascii names (*)
- post commit hook for tags genration
- basic .gitignore for swapfiles and the like
- creates first commit for this basic structure

*(mostly copied from https://github.com/githubbrowser/Pre-commit-hooks)

*Copyright (c) 2013, Freek Kalter*
