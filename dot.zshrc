# Created by newuser for 5.0.2

source ~/mindots/zshrc/keybind

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

  if ! (($+functions[compdef])); then
    autoload -U compinit
    compinit -u
  fi

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
