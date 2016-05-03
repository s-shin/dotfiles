
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
for lang in $(ls -a ~ | grep -e "^\.[a-z]\+env$"); do
  if [[ -d $HOME/.${lang}env ]]; then
    eval "$(${lang}env init -)"
  fi
done

# alias
alias ls="ls -G"
alias ll="ls -lG"
alias la="ls -alG"

# . $HOME/dotfiles/.bashrc
