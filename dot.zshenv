#!/bin/zsh
# For multi-user site.
umask 002

if (($path[(ri)$HOME/bin] > $#path)); then

  # to keep unique elements.
  typeset -U path

  path+=(
      ~/Local/bin
      ~/mytools
      ~/db/bin
      ~/bin
      ~/db/devbox/tools
      ~/.cargo/bin
  )
fi

if [[ -n $DISPLAY && -z $XAUTHORITY ]]; then
  export XAUTHORITY=~$USER/.Xauthority
fi

() {
    local fn
    for fn in ~/.zshenv.$HOST ~/Local/dotzsh/zshenv; do
        [[ -r $fn ]] || continue
        source $fn
    done
}
