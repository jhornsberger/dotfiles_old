# .bashrc

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

if [ -z ${ARTOOLS_NOPROMPTMUNGE} ] && [[ $- == *i* ]]; then  # check if interactive shell
   # nix configuration
   if [ -x "$HOME/bin/nix-enter" ]; then
      if [ ! -e /nix/var/nix/profiles ] || [ -z ${NIX_ENTER+x} ]; then
         export NIX_ENTER=""
         exec "$HOME/bin/nix-enter"
      fi
   fi
   if [[ -x "/nix/var/nix/profiles/default/bin/bash" && $(readlink -f /proc/$$/exe) != *nix* ]]; then
      exec "/nix/var/nix/profiles/default/bin/bash"
   fi
fi

# User specific aliases and functions
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -z ${ARTOOLS_NOPROMPTMUNGE} ] && [[ $- == *i* ]]; then  # check if interactive shell
   export HISTSIZE=50000
   export HISTCONTROL=ignoreboth:erasedups
   shopt -s histappend
   PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

   export PATH=$HOME/bin:$PATH
   export EDITOR=vim
   export P4MERGE=amergeVim
   export NOTI_PB=o.xXcIRDklt4berjLHFbbiwOe7f8QjRDml
   export TMUX_TMPDIR=$HOME/.tmux/sockets

   # Set bash prompt
   function _update_ps1() {
      PS1="$(powerline-go -error $? -mode plain -cwd-mode plain -theme low-contrast -modules 'time,cwd,exit' )"
   }

   if [ "$TERM" != "linux" ] && [ -x "$(command -v powerline-go)" ]; then
      PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
   fi
fi

# Gitar
export GERRIT_HOST=pg-gerrit.infra.corp.arista.io
export GERRIT_SSH_PORT=29410
export GERRIT_TRUNK=gitarband-trunk

# Colors
if [ -x "$(command -v dircolors)" ]; then
   eval `dircolors ~/.dircolors`
fi

# Aliases
alias tt='tmux display-message "Task complete in #S"'
alias vi='vim -u NONE'
alias pb='curl -F c=@- pb'

# Fzf
_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"

  # Comment and uncomment below for the light theme.

  ## Solarized Dark color scheme for fzf
  #export FZF_DEFAULT_OPTS="
  #  --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
  #  --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
  #"
  # Solarized Light color scheme for fzf
  export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue,border:$base2
    --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
    --bind alt-p:toggle-preview
  "
}
_gen_fzf_default_opts
export FZF_DEFAULT_COMMAND='rg --files'
export RIPGREP_CONFIG_PATH=~/.ripgreprc

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
