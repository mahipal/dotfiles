# Basics
export EDITOR=vim
bindkey -v
setopt auto_cd beep extended_glob no_match
unsetopt notify
typeset -U path

# History Mechanism
HISTFILE=~/.zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt hist_verify
setopt append_history inc_append_history share_history extended_history
setopt hist_ignore_dups hist_expire_dups_first

# Prompt
export PS1='%F{242}(%*)%f %F{47}%#%f %F{242}%n %M%f %~ %F{47}%#%f '
# TODO: Add git-prompt functionality.

# ls (BSD)
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export CLICOLOR=1

# ls (GNU)
# TODO: LS_COLORS and ls alias

# grep
# GREP_OPTIONS is deprecated, so use an alias instead.
alias grep='grep --color=auto'

# Completion System Basics (lines generated by compinstall)
zstyle ':completion:*' auto-description '%d'
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format '%d:'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s (%l)'
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/Users/paul/.zshrc'
autoload -Uz compinit
compinit

# Git
gl() {
paste -d' ' <(git log --color --pretty=format:'%ai' "$@") <(git log --color --oneline --decorate "$@")
}
alias gsync="git checkout master && git pull origin master && git fetch origin && git remote prune origin"
