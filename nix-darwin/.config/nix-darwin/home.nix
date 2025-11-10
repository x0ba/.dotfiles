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
    fzf
    git
    git-lfs
    maven
    neovim
    pyenv
    ripgrep
    stow
    nodePackages_latest.vercel
    yazi
    zellij
    direnv
  ];

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
}
