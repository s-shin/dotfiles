# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

# git
if [ -f ~/dotfiles/git-completion.bash ]; then
    source ~/dotfiles/git-completion.bash
fi

# plenv
if [ -d ~/.plenv ]; then
    export PATH="$HOME/.plenv/bin:$PATH"
    eval "$(plenv init -)"
fi

# rbenv
if [ -d ~/.rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

alias ls="ls -G"
alias ll="ls -l"
alias la="ls -al"

export TERM="xterm-256color"

PS1="[\u@\h:\w]\n$ "

