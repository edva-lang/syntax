# Custom Git-aware ZSH prompt definition

autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats ' %F{green}(%b)%f'
zstyle ':vcs_info:git*' actionformats ' %F{red}(%b|%a)%f'

precmd() {
    vcs_info
}

PROMPT='%F{cyan}%~%f${vcs_info_msg_0_} %F{yellow}❯%f '
RPROMPT='%F{gray}%*%f'
