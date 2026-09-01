{ config, lib, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in
{
  home.username = "bowluckie";
  home.homeDirectory = "/home/bowluckie";
  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "brave";
    XDG_DEFAULT_BROWSER = "brave";
    GTK_IM_MODULE = "wayland";
    XDG_SESSION_TYPE = "wayland";
    GDK_SCALE = "1";
    XCURSOR_SIZE = "24";
    LIBINPUT_MODEL_NATURAL_SCROLL = "1";
    PNPM_HOME = "$HOME/.local/share/pnpm";
  };

  home.sessionPath = [
    "$HOME/go/bin"
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.local/share/pnpm"
    "$HOME/.dotnet/tools"
  ];

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        "zsh-vi-mode"
      ];
    };

    initContent = lib.mkMerge [
      (lib.mkOrder 500 ''
        ZSH_CUSTOM="/usr/share/oh-my-zsh/custom"
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#a89984"
      '')
      (lib.mkOrder 1000 ''
        if pacman -Qi yay &>/dev/null; then
         aurhelper="yay"
      elif pacman -Qi paru &>/dev/null; then
         aurhelper="paru"
      fi

      function in {
        local -a inPkg=("$@")
        local -a arch=()
        local -a aur=()

        for pkg in "''${inPkg[@]}"; do
            if pacman -Si "''${pkg}" &>/dev/null; then
                arch+=("''${pkg}")
            else
                aur+=("''${pkg}")
            fi
        done

        if [[ ''${#arch[@]} -gt 0 ]]; then
            sudo pacman -S "''${arch[@]}"
        fi

        if [[ ''${#aur[@]} -gt 0 ]]; then
            ''${aurhelper} -S "''${aur[@]}"
        fi
      }

      alias c='clear'
      alias clr='clear && tmux clear-history'
      alias l='eza -lh --icons=auto'
      alias ls='eza -1 --icons=auto'
      alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
      alias ld='eza -lhD --icons=auto'
      alias lt='eza --icons=auto --tree'
      alias un='$aurhelper -Rns'
      alias up='$aurhelper -Syu'
      alias pl='$aurhelper -Qs'
      alias pa='$aurhelper -Ss'
      alias pc='$aurhelper -Sc'
      alias po='$aurhelper -Qtdq | $aurhelper -Rns -'
      alias snvim='sudo -E nvim'
      alias wqa='exit'
      alias ZZ='exit'

      alias ..='cd ..'
      alias ...='cd ../..'
      alias .3='cd ../../..'
      alias .4='cd ../../../..'
      alias .5='cd ../../../../..'

      alias mkdir='mkdir -p'

      alias win='cd /mnt/c/Users/LUCKB23/'

      # Alt+h/j/k/l -> Left/Down/Up/Right arrows
      bindkey '^[h' backward-char
      bindkey '^[j' down-line-or-history
      bindkey '^[k' up-line-or-history
      bindkey '^[l' forward-char

      eval "$(oh-my-posh init zsh --config ${dotfiles}/oh-my-posh/gruvbox.json)"

      # opam configuration
      [[ ! -r '/home/bowluckie/.opam/opam-init/init.zsh' ]] || source '/home/bowluckie/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null

      fastfetch_load() {
          local min_cols=100
          local min_lines=24

          if (( COLUMNS < min_cols || LINES < min_lines )); then
              command fastfetch --config ~/.config/fastfetch/logo-only.jsonc
          else
              command fastfetch --config ~/.config/fastfetch/config.jsonc
          fi
      }

      if [[ "$TERM_PROGRAM" != "vscode" && "$TERM_PROGRAM" != "Code" && "$TERM_PROGRAM" != "Zed" && "$TERM" != "xterm-256color" ]]; then
        fastfetch_load
      fi

      eval "$(pacman -Qqe > ~/pkglist.txt)"

      if command -v tmux >/dev/null 2>&1 && [ -z "$TMUX" ]; then
          tmux attach-session -t 0 2>/dev/null || tmux new-session
      fi
      '')
    ];
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    escapeTime = 10;
    extraConfig = ''
      set -g status off

      bind -n C-e next-window
      bind C-x confirm-before -p "kill-session #S? (y/n)" kill-session

      bind-key -n C-[ copy-mode

      bind-key -T copy-mode-vi C-n send-keys -X page-down
      bind-key -T copy-mode-vi C-p send-keys -X page-up

      unbind-key -T copy-mode-vi C-f
      unbind-key -T copy-mode-vi C-b

      bind-key -n C-` next-window
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "bowluckie";
      user.email = "bowluckie@gmail.com";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  xdg.configFile = {
    "ghostty".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/ghostty";
    "btop".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/btop";
    "fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/fastfetch";
    "waybar".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/waybar";
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/nvim";
  };

  home.file = {
    ".clang-format".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.clang-format";
    ".clang-tidy".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.clang-tidy";
    ".local/bin/dot-move".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.local/bin/dot-move";
    ".local/bin/devsession".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.local/bin/devsession";
    "Pictures/wallpapers".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/Pictures/wallpapers";
  };

  programs.home-manager.enable = true;
}
