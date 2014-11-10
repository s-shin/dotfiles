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

# share history
# http://iandeth.dyndns.org/mt/ian/archives/000651.html
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=9999

# git
if [ -f ~/dotfiles/git-completion.bash ]; then
    source ~/dotfiles/git-completion.bash
fi

langs=(pl rb nd py php)
for lang in ${langs[@]}
do
    if [ -d ~/.${lang}env ]; then
        export PATH="$HOME/.${lang}env/bin:$PATH"
        eval "$(${lang}env init -)"
    fi
done

# z
Z_PATH=( `brew --prefix`/etc/profile.d/z.sh )
for file in ${Z_PATH[@]}
do
    if [ -f $file ]; then
        . $file
        break
    fi
done

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/shintaro.seki/.gvm/bin/gvm-init.sh" ]] && source "/Users/shintaro.seki/.gvm/bin/gvm-init.sh"
