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
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "

################################################################################
# Colors
################################################################################

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # pastel colors for ls output
export GREP_OPTIONS='--color=auto' # highlight matches in grep results

################################################################################
# Git
################################################################################

gl() {
  paste -d' ' <(git log --color --pretty=format:'%ai' "$@") <(git log --color --oneline --decorate "$@")
}

gsync() {
  git checkout master
  # Mirror the defaults in .gitconfig.
  git fetch origin --prune
  git rebase origin/master
}

# Git Completion
if hash brew 2>/dev/null; then
  completion="$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
  if test -f $completion; then
    source $completion
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
# Node
################################################################################

export NODE_ENV=development

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
