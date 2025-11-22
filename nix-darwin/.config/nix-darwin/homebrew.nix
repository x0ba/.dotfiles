{ ... }:

{
  # Homebrew needs to be installed on its own!
  homebrew = {
    enable = true;
    casks = [
      "bitwarden"
      "google-chrome"
      "keka"
      "ollama-app"
      "slack"
      "zed"
      "affinity"
      "chatgpt-atlas"
      "iina"
      "orbstack"
      "cursor"
      "steam"
      "zoom"
      "anki"
      "claude"
      "imageoptim"
      "lunar-client"
      "prismlauncher"
      "sublime-text"
      "warp"
      "betterdisplay"
      "linearmouse"
      "legcord"
      "arc"
      "istat-menus"
      "notion"
      "visual-studio-code"
      "arduino-ide"
      "figma"
      "jetbrains-toolbox"
      "notion-calendar"
      "rectangle"
      "vivaldi"
      "balenaetcher"
      "ghostty"
      "jordanbaird-ice@beta"
      "obsidian"
      "rocket"
      "yubico-authenticator"
    ];
    brews = [ ];
    taps = [ ];
  };
}
