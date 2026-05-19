# --- Minimal Bash Config for Low-Latency SSH ---

# Stop if not interactive
[[ $- != *i* ]] && return

# Simple prompt (fast, no git, no subshells)
PS1='\u@\h:\w$ '

# Disable command auto-correction / fancy stuff
set +o histexpand

# Faster terminal behavior
stty -ixon 2>/dev/null

# Avoid slow locale issues
export LC_ALL=C

# Basic aliases (safe + fast)
alias ls='ls -a'

# Use fast editor
export EDITOR=nano

# Prevent slow hostname lookups in prompt
HOSTNAME=$(hostname -s)
PS1='\u@$HOSTNAME:\w$ '


# No welcome messages
[ -f ~/.hushlogin ] || touch ~/.hushlogin

# ==========================
#  TMUX AUTO-START
# ==========================
# Only start if we aren't already in tmux and it's an interactive shell
if [ -z "$TMUX" ] && [ -n "$PS1" ]; then
    tmux attach-session -t main || tmux new-session -s main
fi

# Huge history buffer
export HISTSIZE=10000
export HISTFILESIZE=20000

shopt -s cdspell

alias t='tmux new -A -s main'
