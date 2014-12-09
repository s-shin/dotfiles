# .bash_profile

# global
export TERM="xterm-256color"
PATH="$HOME/bin:$PATH"

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

# enable forward incremental search
# http://maruta.be/intfloat_staff/47
stty stop undef
#bind '"\C-n": forward-search-history'

# check whether homebrew is installed
brew=$(type python >/dev/null 2>&1)

# git completion
if [ -f $HOME/dotfiles/git-completion.bash ]; then
    source $HOME/dotfiles/git-completion.bash
fi

# git prompt
if [ -f $HOME/dotfiles/git-prompt.sh ]; then
    source $HOME/dotfiles/git-prompt.sh
fi

# bash-git-prompt
# https://github.com/magicmonty/bash-git-prompt
# if $brew; then
#     if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
#         GIT_PROMPT_THEME=Default
#         #source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
#     fi
# else
#     if [ -f $HOME/dotfiles/gitprompt.sh ]; then
#         GIT_PROMPT_THEME=Default
#         source $HOME/dotfiles/gitprompt.sh
#     fi
# fi

# *env
langs=(pl rb nd py php)
for lang in ${langs[@]}
do
    if [ -d $HOME/.${lang}env ]; then
        export PATH="$HOME/.${lang}env/bin:$PATH"
        eval "$(${lang}env init -)"
    fi
done

# z
z_path=( /etc/profile.d/z.sh )
if $brew; then
    z_path=( `brew --prefix`/etc/profile.d/z.sh "${array[@]}" )
fi
for file in ${z_path[@]}
do
    if [ -f $file ]; then
        source $file
        break
    fi
done

# gvm
#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "$HOME/.gvm/bin/gvm-init.sh" ]] && source "$HOME/.gvm/bin/gvm-init.sh"

# prompt
#export PS1="[\u@\h:\w]\n$ "
# with git-prompt
# export GIT_PS1_SHOWDIRTYSTATE=1
# export GIT_PS1_SHOWCOLORHINTS=1
# export GIT_PS1_SHOWUNTRACKEDFILES=1
# export GIT_PS1_SHOWUPSTREAM="auto"
# export GIT_PS1_DESCRIBE_STYLE="default"
psBegin="\033[0;37m[\033[0m"
psBody="\[\033[0;37m\]\u@\h\[\033[00m\]:\[\033[0;37m\]\w"
#psGit="git => \[\033[0;37m\]$(__git_ps1 '(%s)')\[\033[00m\]"
psIfGit='$(if git status &>/dev/null; then echo "(git:"$(__git_ps1 '%s')")"; fi)'
psEnd="\033[0;37m]\033[0m"
export PS1="${psBegin}${psBody}${psEnd} \033[1;30m${psIfGit}\033[0m\n\$ "

# alias
alias ls="ls -G"
alias ll="ls -lG"
alias la="ls -alG"

# .bashrc
if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

