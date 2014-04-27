# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

# plenv
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

alias ls="ls -G"
alias ll="ls -l"
alias la="ls -al"

export TERM="xterm-256color"

PS1="[\u@\h:\w]\n$ "

