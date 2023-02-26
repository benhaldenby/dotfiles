# Shortcuts
alias ls="ls -al"      # List in long format, include dotfiles
alias ld="ls -ld */"   # List in long format, only directories
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Copy SSH keys to clipboard
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias copysshben="pbcopy < $HOME/.ssh/id_rsa_ben.pub"

# Recursively remove .DS_Store files
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"

# Directories
alias dotfiles="cd $DOTFILES"
# alias library="cd $HOME/Library"

# Git
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias diff="git diff"
alias force="git push --force"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"



# Laravel
# alias a="php artisan"
# alias fresh="php artisan migrate:fresh --seed"
# alias tinker="php artisan tinker"
# alias seed="php artisan db:seed"
# alias serve="php artisan serve"

# PHP
# alias cfresh="rm -rf vendor/ composer.lock && composer i"
# alias composer="php -d memory_limit=-1 /opt/homebrew/bin/composer"

# JS
# alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
# alias watch="npm run watch"

# Docker
# alias docker-composer="docker-compose"

# SQL Server
# alias mssql="docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=LaravelWow1986! -p 1433:1433 mcr.microsoft.com/mssql/server:2017-latest"