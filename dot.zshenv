# For multi-user site.
umask 002

# to keep unique elements.
typeset -U path
path+=(
    ~/Local/bin
    ~/mytools
)

if [[ -r ~/Local/zshenv ]]; then
  source ~/Local/zshenv
fi
