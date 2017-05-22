
tmpdir=$HOME/dotfiles/tmp
mkdir -p $tmpdir

function source_url() {
  local url=$1
  local file=$(echo $url | rev | cut -d/ -f1 | rev)
  cd $tmpdir
  if [[ ! -s $file ]]; then
    curl -sLO $url
  fi
  . $file
  cd - > /dev/null
}

for url in \
  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh \
  https://raw.githubusercontent.com/github/hub/master/etc/hub.bash_completion.sh \
  https://raw.githubusercontent.com/rupa/z/master/z.sh \
; do
  source_url $url
done

# *env
for dotlangenv in $(ls -a ~ | grep -e "^\.[a-z]\+env$"); do
  langenv=$(echo $dotlangenv | cut -c 2-)
  if [[ -d $HOME/.${langenv} ]]; then
    eval "$(${langenv} init -)"
  fi
done

# gvm
if [[ -f $HOME/.gvm/scripts/gvm ]]; then
  . $HOME/.gvm/scripts/gvm
fi
# modify GOPATH here since gvm init GOPATH.
export GOPATH=$GOPATH:$HOME/.go
export GOBIN=$HOME/.go/bin
export PATH=$HOME/.go/bin:$PATH
if [[ -d $HOME/.ghq ]]; then
    export GOPATH=$GOPATH:$HOME/.ghq
fi

# alias
alias ls="ls -G"
alias ll="ls -lG"
alias la="ls -alG"

alias ghql='cd $(ghq root)/$(ghq list | peco)'
#alias gitb='git branch | peco | sed -e "s/\* //g" | awk "{print \$1}"'
alias gitb='git branch -a | peco | sed -e "s/\* //g" | awk "{print \$1}" | perl -ple "s%remotes/[^/]+/%%"'
alias gitc='git symbolic-ref --short HEAD'
#alias hubc='hub compare $(gitb)...$(gitc)'
alias hubc='hub compare $(gitb)...$(gitc)'

sshq() {
  if name="$(cat ~/.ssh/config | grep -E 'Host\s' | grep -v '*' | perl -ple 's/^Host\s+(.+)$/$1/' | peco)"; then
    ssh "$name"
  fi
}

# . $HOME/dotfiles/.bashrc

