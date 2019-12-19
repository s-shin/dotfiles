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

# alias
alias ls="ls -G"
alias ll="ls -lhG"
alias la="ls -alG"
alias gitc='git symbolic-ref --short HEAD'

# completions
if [[ -d /usr/local/share/zsh-completions ]]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

ghql() {
  local p="$(ghq list | peco)"
  if [[ -n "$p" ]]; then
    cd "$(ghq root)/${p}"
  fi
}
