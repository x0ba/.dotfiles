# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a nix-darwin configuration repository that manages a macOS system using Nix flakes. The configuration includes both system-level settings (via nix-darwin) and user-level package management (via home-manager). The system is configured for an M1/M2 Mac (aarch64-darwin).

## Architecture

The configuration is split into two main files:

- **flake.nix**: Defines the system configuration including:
  - System packages (environment.systemPackages)
  - macOS system defaults (trackpad, dock, finder, keyboard settings, etc.)
  - Homebrew casks for GUI applications
  - home-manager integration
  - Development shell with nix-darwin tooling

- **home.nix**: Defines user-level packages and configuration managed by home-manager. This is where CLI tools and user-specific applications live.

The flake exports two configurations:
1. `darwinConfigurations."Daniels-Macbook-Air"` - Full system configuration
2. `homeConfigurations.daniel` - Standalone home-manager configuration

## Common Commands

### Apply System Changes
```bash
# Apply system configuration changes (requires sudo)
darwin-rebuild switch --flake .#Daniels-Macbook-Air

# Apply only home-manager changes (no sudo required)
home-manager switch --flake .#daniel
```

### Update Dependencies
```bash
# Update flake.lock with latest versions
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs
```

### Development Shell
```bash
# Enter development environment with formatting/linting tools
nix develop
```

### Code Quality
```bash
# Format all Nix files
nixfmt *.nix

# Check for issues and anti-patterns
statix check .

# Find unused code
deadnix .
```

### Debugging
```bash
# Visualize dependency tree
nix-tree

# Compare two system generations
nvd diff /run/current-system /nix/var/nix/profiles/system-*-link

# View derivation diff
nix-diff derivation1.drv derivation2.drv
```

## Key Configuration Details

- **Primary user**: daniel
- **System**: aarch64-darwin (Apple Silicon)
- **Nix management**: Managed by Determinate Systems installer (nix.enable = false in config)
- **Homebrew**: Managed through nix-darwin with cleanup on activation (onActivation.cleanup = "zap")
- **home-manager backup extension**: "backup" (old files backed up during activation)
- **System packages**: Installed via environment.systemPackages in flake.nix
- **User packages**: Installed via home.packages in home.nix
- **GUI applications**: Managed through Homebrew casks in flake.nix

## Adding Packages

- CLI tools for user: Add to `home.packages` in home.nix
- System-wide CLI tools: Add to `environment.systemPackages` in flake.nix
- GUI applications: Add to `homebrew.casks` in flake.nix

## Important Notes

- The system uses direnv (note the .envrc file)
- TouchID is enabled for sudo authentication
- All macOS automatic text substitutions are disabled (no autocorrect, autocapitalization, etc.)
- Fast key repeat settings configured (KeyRepeat = 2, InitialKeyRepeat = 15)
- Unfree packages are allowed system-wide
