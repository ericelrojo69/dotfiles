# Alias
alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Prompt
PS1="\W\\$\[$(tput sgr0)\]"

# Vi mode
set -o vi
