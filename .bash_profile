# Prompt
export PS1='\[\033[0;30;1m\](\t) \[\033[32;1m\]$ \[\033[0;30;1m\]\u ${HOSTNAME} \[\033[0;37m\]\w \[\033[32;1m\]$ \[\033[0m\]'

# Colors
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # pastel colors for ls output
export GREP_OPTIONS='--color=auto' # highlight matches in grep results

# Homebrew Configuration
export HOMEBREW_NO_ANALYTICS=1

# Git Commands
gl() {
  paste -d' ' <(git log --color --pretty=format:'%ai' "$@") <(git log --color --oneline --decorate "$@")
}
gsync() {
  git checkout master
  # Mirror the defaults in .gitconfig.
  git fetch origin --prune
  git rebase origin/master
}

# If we're using Homebrew's git, set up additional git features.
if hash brew 2>/dev/null; then
  # Git Prompt
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

  # Git Auto-Completion
  completion="$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
  if test -f $completion; then
    source $completion
  fi
fi

# Ruby
export RACK_ENV=development
export NODE_ENV=development
export JRUBY_OPTS="-J-XX:MaxPermSize=256M"
alias b="bundle exec"

# rbenv
if hash rbenv 2>/dev/null; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
