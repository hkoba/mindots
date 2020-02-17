# -*- mode: shell-script; sh-shell: zsh; coding: utf-8 -*-

source ${$(readlink -f ~/.zshrc):h}/zshrc/keybind

() {
  autoload colors; colors

  if [[ $TERM == dumb ]]; then
    PROMPT='%# '
    setopt no_zle no_prompt_cr no_prompt_sp
  elif ((UID == 0)); then
    PROMPT='%S%m%s%K{red}%# %k'
  else
    PROMPT='%S%m%s%# '    # default prompt
  fi
  if [[ $TERM != dumb ]]; then
    RPROMPT='%(?..%K{red} ERROR!) %B%~%b%k'
  else
    RPROMPT=' %~'
  fi

  local o opts
  opts=(
    # History related.
    extended_history inc_append_history hist_ignore_dups no_bang_hist

    # File globbing related.
    extended_glob numeric_glob_sort

    # Prompt
    transient_rprompt

    # Other
    auto_cd

    no_flow_control

    autolist list_types nohup correct autocd

    autopushd pushdignoredups pushdsilent  pushdtohome

    interactivecomments

    braceccl printeightbit MAGIC_EQUAL_SUBST
  )

  setopt $opts
  # Optional settings.
  opts=(
    inc_append_history_time
  )
  for o in $opts; do
    (($+options[$o])) || continue
    setopt $o
  done

  HISTFILE=$HOME/.zhistory
  HISTSIZE=5000
  SAVEHIST=$[HISTSIZE*100]

  local dn fn _fn
  for dn in ~/mindots/zfunc ~/hktools/zfuncs; do
    [[ -d $dn ]] || continue
    fpath+=($dn)
    autoload $dn/*(:t)
  done

  for fn in ~/.zshrc.$HOST ~/Local/dotzsh/zshrc; do
      [[ -r $fn ]] || continue
      source $fn
  done
  
  if ! (($+functions[compdef])); then
    autoload -U compinit
    compinit -u
  fi
}
