# home.nix
# home-manager switch

{ config, pkgs, ... }:

{
  home.username = "daniel";
  home.homeDirectory = "/Users/daniel";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = with pkgs; [
    eza
    fd
    tmux
    fzf
    git
    git-lfs
    tealdeer
    maven
    neovim
    pyenv
    ripgrep
    gh
    fnm
    lazygit
    zoxide
    claude-code
    gettext
    stow
    yazi
    zellij
    direnv

    # fonts
    geist-font
  ];

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
}
