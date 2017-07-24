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
  () {
    local fn rel dst
    for fn in $thisDir/dot.*; do
       dst=$HOME/$fn:t:s/dot././
       [[ -e $dst ]] || x ln -vnsfr $fn $dst
    done
  }
} always {
    (($#o_dryrun)) || echo DONE
}
