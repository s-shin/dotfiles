# NOTE: .zshenv is for login and interactive shells.

### General Environment Variables

# https://code.visualstudio.com/docs/setup/mac#_alternative-manual-instructions
if [[ -d "/Applications/Visual Studio Code.app" ]]; then
  export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# https://docs.brew.sh/Analytics
export HOMEBREW_NO_ANALYTICS=1

export FILTER=fzf
export FZF_DEFAULT_OPTS='--bind ctrl-k:kill-line --layout=reverse'

### Runtime Version Managers

if type brew >/dev/null 2>&1; then
  if [[ -f "$(brew --prefix)/opt/asdf/libexec/asdf.sh" ]]; then
    . "$(brew --prefix)/opt/asdf/libexec/asdf.sh"
  fi
fi

# TODO: remove
for dotlangenv in $(ls -a "$HOME" | grep -e "^\.[a-z]\+env$"); do
  langenv="$(echo "$dotlangenv" | cut -c 2-)"
  if [[ -d "$HOME/.${langenv}" ]]; then
    eval "$(${langenv} init -)"
  fi
done

if [[ -f "$HOME/.gvm/scripts/gvm" ]]; then
  . "$HOME/.gvm/scripts/gvm"
fi

### zsh

export WORDCHARS=""

# zsh completions
if type brew >/dev/null 2>&1; then
  if [[ -f "$(brew --prefix)/share/zsh-completions" ]]; then
    fpath=("$(brew --prefix)/share/zsh-completions" "$fpath")
    fpath=("$(brew --prefix)/share/zsh/site-functions" "$path")
  fi
fi

# compinit
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
zstyle ":completion:*:commands" rehash 1

# history
HISTFILE="${HOME}/.zsh_history"
SAVEHIST=10000
setopt hist_no_store
setopt hist_ignore_dups
setopt hist_verify
setopt extended_history
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_ignore_all_dups
setopt inc_append_history
setopt share_history

history-all() { fc -li 1 "$@"; }

### Aliases & Helpers

alias ls='ls -G'
alias lh='ls -alhG'
alias gitb='git branch -a | peco | sed -e "s/\* //g" | awk "{print \$1}" | perl -ple "s%remotes/[^/]+/%%"'
alias gitc='git symbolic-ref --short HEAD'
alias hubc='hub compare $(gitb)...$(gitc)'

ghql() {
  local p="$(ghq list | peco)"
  if [[ -n "$p" ]]; then
    cd "$(ghq root)/${p}"
  fi
}

# TODO: redesign
ssh-list() { cat ~/.ssh/config | grep -E '^Host\s' | grep -v '*' | perl -ple 's/^Host\s+(.+)$/$1/'; }
ssh-close() { ssh -O exit "$name"; }
sshq() {
  local name
  if name="$(ssh-list | peco)" && [[ -n "$name" ]]; then
    ssh "$name"
  fi
}
ssh.to() {
  local name
  if name="$(compgen -A 'function' ssh.to. | cut -f3 -d. | peco)" && [[ -n "$name" ]]; then
    "ssh.to.${name}"
  fi
}

# fzf completions
_fzf_files=()
if type brew >/dev/null 2>&1; then
  _fzf_files+=(
    $(brew --prefix)/opt/fzf/shell/completion.zsh
    $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
  )
fi
for _fzf_file in "${_fzf_files[@]}"; do
  if [[ -f "$_fzf_file" ]]; then
    source "$_fzf_file"
  fi
done

### zplug

# export ZPLUG_HOME=/usr/local/opt/zplug
# if [[ -d "$ZPLUG_HOME" ]]; then
#  source "${ZPLUG_HOME}/init.zsh"
# fi

# Starship

if type starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  # simple prompt
  setopt prompt_subst
  autoload -Uz vcs_info
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr '!'
  zstyle ':vcs_info:git:*' unstagedstr '+'
  zstyle ':vcs_info:*' formats '(%c%u%b)'
  zstyle ':vcs_info:*' actionformats '(%b|%a)'
  precmd() { vcs_info }
  PROMPT=$'[%n@%m:%~] %F{240}${vcs_info_msg_0_}%f
  $ '
fi
