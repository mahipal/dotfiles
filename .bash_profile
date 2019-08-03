################################################################################
# Prompt
################################################################################

export PS1='\[\033[0;30;1m\](\t) \[\033[32;1m\]$ \[\033[0;30;1m\]\u ${HOSTNAME} \[\033[0;37m\]\w \[\033[32;1m\]$ \[\033[0m\]'

# Git Prompt
if hash brew 2>/dev/null; then
  git_promptable="$(brew --prefix)/etc/bash_completion.d/git-prompt.sh"
  if test -f $git_promptable; then
    source $git_promptable
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWCOLORHINTS=true
    unset PS1
    export PROMPT_COMMAND='__git_ps1 "\[\033[0;30;1m\](\t) \[\033[32;1m\]$ \[\033[0;30;1m\]\u ${HOSTNAME} \[\e[0m\]\w" " \[\033[32;1m\]$ \[\033[0m\]"'

    # New tabs in Apple Terminal should open in the same working directory.
    function_exists() {
      declare -f -F $1 > /dev/null
      return $?
    }
    if function_exists update_terminal_cwd; then
      export PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
    fi
  fi
fi

################################################################################
# History
################################################################################

shopt -s histappend
export HISTFILESIZE=1000000
export HISTSIZE=10000
export HISTTIMEFORMAT="[%F %T] "
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# export HISTFILE="~/.bash_endless_history"

################################################################################
# Colors
################################################################################

export CLICOLOR=1 # enable ls colors (macOS)
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # pastel colors for ls output
export GREP_OPTIONS='--color=auto' # highlight matches in grep results

################################################################################
# Git
################################################################################

# convenience shortcut for git log with preferred format
# also passes args through to underlying git-log commands
# example usage:
#   $ gl -n20
gl() {
  paste -d' ' <(git log --color --pretty=format:'%ai' "$@") <(git log --color --oneline --decorate "$@")
}


# "sync up the git repo with upstream"
#
# Switch to the default branch for the repo, and get up to date.
#
# This takes one optional arg, which is the name of the default branch.
# The master branch is assumed if no arg is passed in.
gsync() {
  git fetch origin
  git remote prune origin
  # If there are any uncommitted changes, go no further.
  if [[ -n "$(git status --porcelain)" ]]; then
    return
  fi
  git checkout "${1:-master}"
  git rebase origin/${1:-master}
}

# "git rebase on top of"
#
# Get the repo up to date, then rebase the current branch on top of the latest
# version of the default branch.
#
# This takes one optional arg, which is the name of the default branch.
# The master branch is assumed if no arg is passed in.
gro () {
  gsync "${1:-master}"
  git checkout "@{-1}"
  git rebase "${1:-master}"
}

# Git Completion
if hash brew 2>/dev/null; then
  git_completable="$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
  if test -f $git_completable; then
    source $git_completable
  fi
fi

################################################################################
# Ruby
################################################################################

alias b="bundle exec"

# rbenv
if [[ -d "$HOME/.rbenv" ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

################################################################################
# Node (via nvm)
################################################################################

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

################################################################################
# Python
################################################################################

# TODO: Set up pyenv.

################################################################################
# Miscellaneous
################################################################################

#----------------------
# Environment Variables
#----------------------

export EDITOR=vim
export HOMEBREW_NO_ANALYTICS=1

#-----------------
# Additional Paths
#-----------------

# Postgres.app
if [[ -d "/Applications/Postgres.app" ]]; then
  export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
fi

#------------------
# Helpful Functions
#------------------

# Find the total memory % used by an app (e.g. Chrome or Firefox) that spawns
# many subprocesses. To use, pass a string (case-insensitive) that is shared by
# all the process names. Example:
#
#   total_memory firefox
#
total_memory() {
  paste -s -d'+' <(ps -eo pmem,comm | grep -i $1 | sed 's/^ //' | cut -d " " -f 1) | bc
}
