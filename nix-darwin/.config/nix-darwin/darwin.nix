{ pkgs, self, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    direnv
    sshs
    glow
    nushell
    carapace
    emacs-macport
  ];

  # Set primary user for system-wide options
  system.primaryUser = "daniel";

  nix.settings.experimental-features = "nix-command flakes";
  programs.zsh.enable = true; # default shell on catalina
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Updated from deprecated security.pam.enableSudoTouchIdAuth
  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.daniel.home = "/Users/daniel";
  home-manager.backupFileExtension = "backup";

  system.defaults = {
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };
    dock.autohide = false;
    dock.orientation = "bottom";
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = "lock in bro";
    screensaver.askForPasswordDelay = 10;
    NSGlobalDomain = {
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      # 120, 90, 60, 30, 12, 6, 2
      KeyRepeat = 2;

      # 120, 94, 68, 35, 25, 15
      InitialKeyRepeat = 15;

      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.volume" = 0.0;
      "com.apple.sound.beep.feedback" = 0;
    };
  };

  # let determinate manage nix
  nix.enable = false;

  # Homebrew needs to be installed on its own!
  homebrew = {
    onActivation.cleanup = "zap";
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
      "logi-options+"
      "orbstack"
      "steam"
      "zoom"
      "anki"
      "claude"
      "imageoptim"
      "lunar-client"
      "prismlauncher"
      "sublime-text"
      "betterdisplay"
      "arc"
      "discord"
      "istat-menus"
      "notion"
      "prusaslicer"
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
    taps = [

    ];
  };
}
