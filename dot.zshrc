# -*- mode: zsh -*-
{
  if [[ $HOME:t != $USER ]]; then
     export HOME=$HOME:h/$USER
  fi
  local fn dotdir
  for dotdir in ~/Local/zshrc ~/mindots/zshrc; do
     [[ -d $dotdir ]] && break
  done
  for fn in $dotdir/*(N); do
     source $fn
  done
  if [[ -r ~/.zshrc.$HOST ]]; then
    source ~/.zshrc.$HOST
  fi
} always {
  unset fn dotdir
}
