{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    let
      configuration =
        { pkgs, ... }:
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
          ];

          # Set primary user for system-wide options
          system.primaryUser = "daniel";

          nix.settings.experimental-features = "nix-command flakes";
          programs.zsh.enable = true; # default shell on catalina
          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 4;
          nixpkgs.hostPlatform = "aarch64-darwin";

          # Updated from deprecated security.pam.enableSudoTouchIdAuth
          security.pam.services.sudo_local.touchIdAuth = true;

          users.users.daniel.home = "/Users/daniel";
          home-manager.backupFileExtension = "backup";

          system.defaults = {
            trackpad = {
              Clicking = true;
              TrackpadThreeFingerDrag = true;
            };
            dock.autohide = true;
            dock.orientation = "left";
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

          nix.enable = false;
          # Homebrew needs to be installed on its own!
          homebrew.enable = true;
          homebrew.casks = [
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
          homebrew.brews = [
          ];
        };
    in
    {
      darwinConfigurations."Daniels-Macbook-Air" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.daniel = import ./home.nix;
          }
        ];
      };

      # Standalone home-manager configuration
      homeConfigurations.daniel = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./home.nix ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Daniels-Macbook-Air".pkgs;

      # Development shell for managing nix-darwin configuration
      devShells.aarch64-darwin.default =
        let
          pkgs = import nixpkgs { system = "aarch64-darwin"; };
        in
        pkgs.mkShell {
          name = "nix-darwin-config";

          buildInputs = with pkgs; [
            # Core nix-darwin tools
            nix-darwin.packages.aarch64-darwin.darwin-rebuild
            home-manager.packages.aarch64-darwin.home-manager

            # Formatting and linting
            nixfmt # Nix code formatter
            statix # Lints and suggestions for Nix code
            deadnix # Find and remove unused code in Nix files

            # Development tools
            nixd # Nix language server
            nix-tree # Visualize Nix dependencies
            nix-diff # Compare Nix derivations
            nvd # Nix version diff tool

            # Utilities
            git # Version control
            jq # JSON processing (useful for nix eval --json)
          ];

          shellHook = ''
            echo "🚀 nix-darwin development environment"
            echo ""
            echo "Available commands:"
            echo "  darwin-rebuild switch --flake .#Daniels-Macbook-Air"
            echo "  home-manager switch --flake .#daniel"
            echo "  nixfmt *.nix              # Format Nix files"
            echo "  statix check .            # Check for issues"
            echo "  deadnix .                 # Find unused code"
            echo "  nix-tree                  # Visualize dependencies"
            echo ""
          '';
        };
    };
}
