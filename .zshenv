export PATH="$HOME/bin:/usr/local/bin:$HOME/dotfiles/bin:$PATH"

if [[ -d "/Applications/Visual Studio Code.app" ]]; then
  export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi
