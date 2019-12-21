### Prompt

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '!'
zstyle ':vcs_info:git:*' unstagedstr '+'
zstyle ':vcs_info:*' formats '(%c%u%b)'
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd () { vcs_info }

PROMPT=$'[%n@%m:%~] %F{240}${vcs_info_msg_0_}%f
$ '

### Aliases

alias ls="ls -G"
alias lh="ls -alhG"
alias gitc='git symbolic-ref --short HEAD'

### Completions

autoload -U compinit && compinit -u

if [[ -d /usr/local/share/zsh-completions ]]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# https://unix.stackexchange.com/a/2180
zstyle ":completion:*:commands" rehash 1

### Helpers

ghql() {
  local p="$(ghq list | peco)"
  if [[ -n "$p" ]]; then
    cd "$(ghq root)/${p}"
  fi
}
