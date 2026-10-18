# Fish shell color settings and helper functions

set -g fish_color_normal normal
set -g fish_color_command 89b4fa --bold
set -g fish_color_param cdd6f4
set -g fish_color_comment 6c7086 --italics
set -g fish_color_quote a6e3a1
set -g fish_color_error f38ba8

function greet --description 'Display greeting with system info'
    echo (set_color green)"Welcome to fish shell, "(whoami)"!"(set_color normal)
    echo "Terminal: $TERM | Host: "(hostname)
end
