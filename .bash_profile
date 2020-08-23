alias g='git'
alias hi=$'printf "Good morning, sir.\n" && sleep 0.3 && printf "Let me pour you some hot chocolate" && sleep 0.3 && printf "." && sleep 0.3 && printf "." && sleep 0.3 && printf "." && sleep 0.15 && \
printf "\n\n                          )     (\n                   ___...(-------)-....___\n               .-\'\'       )    (          \'\'-.\n         .-\'\'\'\'|-._             )         _.-|\n        /  .--.|   \'\'\'---...........---\'\'\'   |\n       /  /    |                             |\n       |  |    |                             |\n        \\  \\   |                             |\n         \'\\ \'\\ |                             |\n           \'\\ \'|                             |\n           _/ /\\                             /\n          (__/  \\                           /\n       _..---\'\'\' \\                         /\'\'\'---.._\n    .-\'           \\                       /          \'-.\n   :               \'-.__             __.-\'              :\n   :                  ) \'\'---...---\'\' (                 :\n    \'._               \'\'--...___...--\'\'              _.\'\n      \\\'\'--..__                              __..--\'\'/\n       \'._     \'\'\'----.....______.....----\'\'\'     _.\'\n          \'\'\'--..,,_____            _____,,..--\'\'\'\n                        \'\'\'\'----\'\'\'\'"'
alias bye='printf "Good night, sir." && sleep 1.0 && printf "\n" && exit'

function strindex() 
{
  X="${1%%$2*}"
  [[ "$X" = "$1" ]] && echo -1 || echo "$[ ${#X} + 1 ]"
}

function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

alias gfetch='git fetch'
alias gpull='git pull'
alias gmasrebase='git fetch && git rebase origin/master'
alias greset='git fetch && git reset --hard origin/$(current_branch)'
alias gforce='read -p "ARE YOU SURE YOU ARE REBASING??? ONLY FORCE PUSH DURING REBASE!!! " -n 1 -r
echo 
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git push --force-with-lease
fi'
alias gpush='git push'
alias uregen='printf "Generating VS project..." && "C:\Program Files (x86)\Epic Games\Launcher\Engine\Binaries\Win64\UnrealVersionSelector.exe" -projectfiles "$PWD\ProjectR3.uproject" && printf "Done\n"'
alias cregen='cmake -S "CMake" -B "CMake/Build"'
alias uvs='start ProjectR3.sln'
alias urvs='uregen && uvs'
alias cvs='start CMake/Build/A1_CMAKE.sln'

alias gstatus='git status'
alias gstat='git status'
alias glog='git log'
alias gdiff='git diff'
alias gcontinue='git rebase --continue'
alias gcont='git rebase --continue'
alias gcpcont='git cherry-pick --continue'

alias tdiff='TortoiseGitProc /command:diff'

cvsc() 
{
  echo "Compiling A1..."
  local x="C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/Common7/IDE/devenv.exe" 
  "$x" CMake//Build//A1_CMAKE.sln //Build Debug //Project ALL_BUILD //ProjectConfig Debug
  echo "Launching A1..."
  start CMake//Build/A1_CMAKE.sln
}

gc()
{
  local parent_branch=""
  if [ $# -eq 1 ]
  then
    parent_branch="origin/master"
  elif [ $# -eq 2 ]
  then
    parent_branch="$2"
  else
    echo "Format error: gc <new_branch> [parent_branch]"
    exit 1
  fi
  git fetch && git checkout "$1" || (git checkout "$parent_branch" && git checkout -b "$1" && git push --set-upstream origin "$1") && printf "Status:\n" && git status
}

gcom()
{
  local branch="$(current_branch)"
  local startfrom="$(strindex "$branch" "R3-")"
  local ticket=""
  if [ $startfrom -gt -1 ]
  then
    ticket="[$(echo "$branch" | cut -c$startfrom-$((startfrom + 6)))] "
  fi
  git add . && (git commit -m "${ticket}$1 ($(date +'%d.%m %H:%M')) ")
}
gcompush()
{
  local branch="$(current_branch)"
  local startfrom="$(strindex "$branch" "R3-")"
  local ticket=""
  if [ $startfrom -gt -1 ]
  then
    ticket="[$(echo "$branch" | cut -c$startfrom-$((startfrom + 6)))] "
  fi
  git add . && (git commit -m "${ticket}$1 ($(date +'%d.%m %H:%M')) ") && git push
}

gsoft()
{
  git reset --soft HEAD~1
  git status
}

guprebase()
{
  local branch="$(current_branch)"
  git fetch && git rebase "origin/$branch"
}

gours()
{
  printf "REBASE ONLY FUNCTIONALITY: using --ours (remote) file: $1" && git checkout --ours "$1" && git add "$1"
}

gtheirs()
{
  printf "REBASE ONLY FUNCTIONALITY: using --theirs (local branch) file: $1" && git checkout --theirs "$1" && git add "$1"
}

gmaster()
{
  printf "using origin/master file: $1" && git checkout origin/master "$1" && git add "$1"
}

gmas()
{
  printf "using origin/master file: $1" && git checkout origin/master "$1" && git add "$1"
}

ghead()
{
  printf "using HEAD file: $1" && git checkout HEAD "$1" && git add "$1"
}

gcp()
{
  git cherry-pick "$1"
}

gadd()
{
  git add "$1"
}

gsubrem()
{
  git submodule deinit --force "$1" && git rm "$1" && git commit -m "Removed submodule $1" && rm -rf ".git/modules/$1"
}