#Cntrl Delete doesnt work and that is a deal breaker
#fish_vi_keybindings --no-erase

# Disable greeting
set fish_greeting

# Abbreviations
abbr --add nxs 'sudo nixos-rebuild switch --flake ~/.dotfiles#'(hostname)
abbr --add hms 'home-manager switch --flake ~/.dotfiles#'(hostname)

# Aliases
alias ls='eza --icons'
alias ll='eza -l --time-style=relative --no-permissions --no-user --icons'
alias la='eza -la --time-style=relative --no-permissions --no-user --icons'

alias nxls='nix-store --query --requisites /run/current-system'
alias nxgc='nix-store --gc && nix-collect-garbage -d && sudo nix-collect-garbage -d'

alias vim='nvim'
alias vi='nvim'

alias ta='tmux attach'
alias tl='tmux ls'

alias ga='git add -A'
alias gc='git commit -m'

# Yazi shell wrapper (https://yazi-rs.github.io/docs/quick-start/#shell-wrapper)
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Has to be here at the end of the file
zoxide init --cmd cd fish | source
