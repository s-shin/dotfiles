# .bash_profile

if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

PS1="[\u@\h:\w]\n$ "
export TERM="xterm-256color"
PATH="$HOME/bin:$PATH"

alias ls="ls -G"
alias ll="ls -lG"
alias la="ls -alG"

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

