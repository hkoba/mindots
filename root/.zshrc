HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=$[HISTSIZE * 1000]
setopt histignoredups
if [[ -f ~$USER/.zshrc.root ]]; then
  source ~$USER/.zshrc.root
fi

if (($+SUDO_USER)); then
    function {
	local rcfn=~$SUDO_USER/.zshrc.sudo.$USER
	if [[ -f $rcfn ]]; then
	    if [[ -t 0 && -t 1 ]]; then
		echo loading rcfn=$rcfn
	    fi
	    source $rcfn
	fi
	if (($+EMAIL_ORGANIZATION)); then
	    export GIT_AUTHOR_EMAIL=$SUDO_USER@$EMAIL_ORGANIZATION
	    export GIT_COMMITTER_EMAIL=$SUDO_USER@$EMAIL_ORGANIZATION
	fi
    }
fi

export GIT_EDITOR=vim
