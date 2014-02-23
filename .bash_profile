#---------------------------------------------------------------------------------------------------
# Command Prompt

export PS1='\[\033[0;30;1m\](\t) \[\033[32;1m\]$ \[\033[0;30;1m\]\u ${HOSTNAME} \[\033[0;37m\]\w \[\033[32;1m\]$ \[\033[0m\]'

# Use git-prompt, if it's at the usual place where Homebrew puts it.
git_promptable="$(brew --prefix)/etc/bash_completion.d/git-prompt.sh"
if test -f $git_promptable
then
  source $git_promptable
  export GIT_PS1_SHOWDIRTYSTATE=true
  export GIT_PS1_SHOWUNTRACKEDFILES=true
  export GIT_PS1_SHOWCOLORHINTS=true
  unset PS1
  export PROMPT_COMMAND='__git_ps1 "\[\033[0;30;1m\](\t) \[\033[32;1m\]$ \[\033[0;30;1m\]\u ${HOSTNAME} \[\e[0m\]\w" " \[\033[32;1m\]$ \[\033[0m\]"'

  # Apple Terminals offer a feature that opens new tabs in the same working
  # directory as the current tab. It works by adding the `update_terminal_cwd`
  # function to the PROMPT_COMMAND. Since we just overwrote PROMPT_COMMAND
  # above, we now have to account for that. See:
  # - http://stackoverflow.com/questions/85880/determine-if-a-function-exists-in-bash
  # - http://superuser.com/questions/623298/os-x-mountain-lion-terminal-tab-name-open-a-new-tab-in-the-same-directory
  function_exists() {
    declare -f -F $1 > /dev/null
    return $?
  }
  if function_exists update_terminal_cwd
  then
    export PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
  fi
fi

# Make `ls` colorful on OSX.
export CLICOLOR=1

# Tell `grep` to highlight matches in results.
export GREP_OPTIONS='--color=auto'

# Use nicer pastel colors for `ls` output.
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

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
