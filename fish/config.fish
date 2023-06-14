if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

neofetch
misfortune -a

starship init fish | source
