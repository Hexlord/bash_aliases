# bash_profile
My bash profile with some useful aliases (mostly git-related)
You have to use bash_profile and not bash_aliases under windows!

## Installation:
1) Run git bash
2) Enter 'cd ~'
3) Enter 'code .bash_profile' (or use nano if you dont have VS Code)
4) Paste .bash_profile content from this repo
5) Save & close .bash_profile
6) Enter 'source .bash_profile'

## Usage:
When in git bash, use 'gcompush [desc]' to automatically commit all files and push them to remote.
Use gmasrebase to rebase to origin/master.
Use gsoft to undo last commit, preserving the file changes.
Use tdiff to open Tortoise Git diff (useful to revert stuff).
Use gforce to be asked whether you are sure you wanna force-push (good habit, saved me from some malicous force-pushes).
