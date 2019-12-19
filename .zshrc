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

export PATH="$HOME/bin:/usr/local/bin:$HOME/dotfiles/bin:$PATH"

# vscode
if [[ -d "/Applications/Visual Studio Code.app" ]]; then
  export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# alias
alias ls="ls -G"
alias ll="ls -lhG"
alias la="ls -alG"
