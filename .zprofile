# NOTE: .zprofile is for login shells.
# Basically, use .zshrc.

### Runtime Version Managers
# TODO: remove

for dotlangenv in $(ls -a "$HOME" | grep -e "^\.[a-z]\+env$"); do
  langenv="$(echo "$dotlangenv" | cut -c 2-)"
  case "$langenv" in
    pyenv ) eval "$(pyenv init --path)";;
  esac
done
