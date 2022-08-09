#!/bin/zsh
# For multi-user site.
umask 002

# to keep unique elements.
typeset -U path

if (($path[(ri)$HOME/db/bin] > $#path)); then

  path+=(
      ~/Local/bin
      ~/mytools
      ~/db/bin
      ~/bin
      ~/.cargo/bin
      ~/db/devbox/tools
      ~/db/devbox/*/bin
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
