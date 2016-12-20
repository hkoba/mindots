# Created by newuser for 5.0.2

source ~/mindots/zshrc/keybind

() {
  local dn fn _fn
  for dn in ~/mindots/zfunc ~/hktools/zfuncs; do
    [[ -d $dn ]] || continue
    fpath+=($dn)
    for fn in $dn/[a-z]*; do
       autoload $fn:t
       _fn=$dn/_$fn:t
       if [[ -r $_fn ]]; then
         autoload $_fn:t
         compdef $_fn:t $fn:t
       fi
    done
    autoload $dn/*(:t)
  done

  fn=~/.zshrc.$HOST
  if [[ -r $fn ]]; then
    source $fn
  fi
}
