#!/bin/zsh

set -u
setopt err_return

thisDir=$(cd $0:h && print $PWD)

o_dryrun=()
zparseopts -D -K n=o_dryrun
function x {
  print -- "$@"
  if (($#o_dryrun)); then
     return
  fi
  "$@"
}

{
  function {
    local fn rel dst
    for fn in $thisDir/dot.*; do
       rel=${fn#$HOME/}
       dst=$HOME/$fn:t:s/dot././
       x ln -vnsf $rel $dst
    done
  }
} always {
  echo DONE
}
