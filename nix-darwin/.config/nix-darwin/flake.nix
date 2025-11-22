{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" ];

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          # Development shell for managing nix-darwin configuration
          devShells.default = pkgs.mkShell {
            name = "nix-darwin-config";

            buildInputs = with pkgs; [
              # Core nix-darwin tools
              inputs'.nix-darwin.packages.darwin-rebuild
              inputs'.home-manager.packages.home-manager

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

      flake =
        let
          inherit (inputs)
            self
            nix-darwin
            nixpkgs
            home-manager
            ;
        in
        {
          # nix-darwin configuration
          darwinConfigurations."Daniels-Macbook-Air" = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            specialArgs = { inherit self; };
            modules = [
              ./darwin.nix
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
            pkgs = import nixpkgs {
              system = "aarch64-darwin";
              config.allowUnfree = true;
            };
            modules = [ ./home.nix ];
          };

          # Expose the package set, including overlays, for convenience.
          darwinPackages = self.darwinConfigurations."Daniels-Macbook-Air".pkgs;
        };
    };
}
