{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in
{
  home.username = "bowluckie";
  home.homeDirectory = "/home/bowluckie";
  home.stateVersion = "26.05";

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
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.zshrc";
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.tmux.conf";
    ".clang-format".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.clang-format";
    ".clang-tidy".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.clang-tidy";
    ".local/bin/dot-move".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.local/bin/dot-move";
    ".local/bin/devsession".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.local/bin/devsession";
    "Pictures/wallpapers".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/Pictures/wallpapers";
  };

  programs.home-manager.enable = true;
}
