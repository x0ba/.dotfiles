{ ... }:

{
  # Homebrew needs to be installed on its own!
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "keka"
      "ollama-app"
      "slack"
      "zed"
      "affinity"
      "iina"
      "orbstack"
      "cursor"
      "steam"
      "anki"
      "claude"
      "imageoptim"
      "lunar-client"
      "prismlauncher"
      "arc"
      "notion"
      "discord"
      "karabiner-elements"
      "figma"
      "jetbrains-toolbox"
      "notion-calendar"
      "rectangle"
      "balenaetcher"
      "ghostty"
      "jordanbaird-ice@beta"
      "obsidian"
      "yubico-authenticator"
      "zen"
    ];
    brews = [ ];
    taps = [ ];
  };
}
