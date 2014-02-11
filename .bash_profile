#---------------------------------------------------------------------------------------------------
# Command Prompt

# export PS1='\[\033[32;1m\]$ \[\033[0;30;1m\]\u ${HOSTNAME} \[\033[0;37m\]\w \[\033[32;1m\]$ \[\033[0m\]'
export PS1='\[\033[0;30;1m\](\t) \[\033[32;1m\]$ \[\033[0;30;1m\]\u ${HOSTNAME} \[\033[0;37m\]\w \[\033[32;1m\]$ \[\033[0m\]'

# Make `ls` colorful on OSX.
export CLICOLOR=1

# Tell `grep` to highlight matches in results.
export GREP_OPTIONS='--color=auto'

# These are some alternate/customized color schemes for `ls` output.
# http://superuser.com/questions/324207/how-do-i-get-context-coloring-in-mac-os-x-terminal
# http://apple.stackexchange.com/questions/33677/how-can-i-configure-mac-terminal-to-have-color-ls-output
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # pastels
# export LSCOLORS=dxfxcxdxbxegedabagacad # (kind of ugly)
# export LSCOLORS=ExFxCxDxBxegedabagacad # default, or close to default -- blue/red/etc.
# export LSCOLORS=gxfxcxdxbxegedabagacad # mix of pastels and default

#---------------------------------------------------------------------------------------------------
# Path

export PATH="~/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

#---------------------------------------------------------------------------------------------------
# Other Environment Variables

export RACK_ENV=development

# JRuby configuration -- otherwise it tends to fall over with this error:
# Error: Your application exhausted PermGen area of the heap.
# Specify -J-XX:MaxPermSize=###M to increase it (### = PermGen size in MB).
# Specify -w for full OutOfMemoryError stack trace
export JRUBY_OPTS="-J-XX:MaxPermSize=256M"

#---------------------------------------------------------------------------------------------------
# Git

# Git Log
# alias g="git"
# alias gl="git log --pretty=format:'%h %ai %d %s'"
gl () {
paste -d' ' <(git log --color --pretty=format:'%ai' "$@") <(git log --color --oneline --decorate "$@")
}

# Use git's autocompletion script (for bash) if it's at the usual place where Homebrew puts it.
completion="$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
if test -f $completion
then
  source $completion
fi

#---------------------------------------------------------------------------------------------------
# Other Niceties

alias b="bundle exec"
alias gsync="git checkout master && git pull origin master && git fetch origin && git remote prune origin"

#---------------------------------------------------------------------------------------------------
# rbenv config

eval "$(rbenv init -)"

#---------------------------------------------------------------------------------------------------
# anything to be done after rbenv configures itself

export PATH="/usr/local/heroku/bin:$PATH"

# AWS things
complete -C aws_completer aws
