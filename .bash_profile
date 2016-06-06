# .bash_profile

# global
export TERM="xterm-256color"
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# homebrew
# http://rcmdnk.github.io/blog/2016/04/28/computer-mac-homebrew/
export HOMEBREW_NO_ANALYTICS=1

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
# http://stackoverflow.com/a/10022396
if [ -t 0 ] && [ -t 1 ]; then
    stty stop undef
fi

# *env
for dotlangenv in $(ls -a ~ | grep -e "^\.[a-z]\+env$"); do
    langenv=$(echo $dotlangenv | cut -c 2-)
    if [ -d $HOME/.${langenv} ]; then
        export PATH="$HOME/.${langenv}/bin:$PATH"
    fi
done

# go (recommends brew & symlink)
export GOPATH=$HOME/.go
export GOBIN=$HOME/.go/bin
export PATH=$HOME/.go/bin:$PATH
if [[ -d $HOME/.ghq ]]; then
    export GOPATH=$GOPATH:$HOME/.ghq
fi

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

# .bashrc
[[ -f $HOME/.bashrc ]] && . $HOME/.bashrc

# . $HOME/dotfiles/.bash_profile
