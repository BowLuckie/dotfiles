ZSH=/usr/share/oh-my-zsh/
ZSH_CUSTOM="/usr/share/oh-my-zsh/custom"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#a89984"

plugins=(
    git
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-vi-mode
)
source $ZSH/oh-my-zsh.sh


export LIBINPUT_MODEL_NATURAL_SCROLL=1
export EDITOR="nvim"
export VISUAL="nvim"

if pacman -Qi yay &>/dev/null; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null; then
   aurhelper="paru"
fi

function in {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()

    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null; then
            arch+=("${pkg}")
        else
            aur+=("${pkg}")
        fi
    done

    if [[ ${#arch[@]} -gt 0 ]]; then
        sudo pacman -S "${arch[@]}"
    fi

    if [[ ${#aur[@]} -gt 0 ]]; then
        ${aurhelper} -S "${aur[@]}"
    fi
}

alias wqa='exit'
alias ZZ='exit'

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias mkdir='mkdir -p'

alias win='cd /mnt/c/Users/'

export BROWSER=brave
export XDG_DEFAULT_BROWSER=brave

export GTK_IM_MODULE=wayland

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH=$HOME/go/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin/:$PATH"

export XDG_SESSION_TYPE=wayland
export GDK_SCALE=1
export XCURSOR_SIZE=24

bindkey '^[h' backward-char
bindkey '^[j' down-line-or-history
bindkey '^[k' up-line-or-history
bindkey '^[l' forward-char

eval "$(oh-my-posh init zsh --config ~/.dotfiles/oh-my-posh/gruvbox.json)"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '~/.opam/opam-init/init.zsh' ]] || source '~/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

fastfetch_load() {
    local min_cols=100
    local min_lines=24

    if (( COLUMNS < min_cols || LINES < min_lines )); then
        command fastfetch --config ~/.config/fastfetch/logo-only.jsonc
    else
        command fastfetch --config ~/.config/fastfetch/config.jsonc
    fi
}

if [[ "$TERM_PROGRAM" != "Code" && "$TERM" != "xterm-256color" ]]; then
  fastfetch_load
fi

eval "$(pacman -Qqe > ~/pkglist.txt)"
export PATH="$PATH:$HOME/.dotnet/tools"

if command -v tmux >/dev/null 2>&1 && [ -z "$TMUX" ]; then
    tmux attach 2>/dev/null || tmux new-session
fi

eval "$(zoxide init zsh)"
