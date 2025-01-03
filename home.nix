{ pkgs, ... }:
let
  sessionVariables = {
    EDITOR = "code";
  };
in
{
  home = {
    stateVersion = "24.11";
    username = "nixos";
    homeDirectory = "/home/nixos";
    sessionVariables = sessionVariables;
    preferXdgDirectories = true;

    packages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];
  };

  xdg.enable = true;

  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      sessionVariables = sessionVariables;
      dotDir = ".config/zsh";
      history.path = ".cache/zsh/history";
    };

    nushell = {
      enable = true;
      extraConfig = builtins.readFile ./nushell/config.nu;
    };

    git = {
      enable = true;
      userName = "Palani Johnson";
      userEmail = "palanijohnson@gmail.com";
      extraConfig.init.defaultBranch = "main";
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";

        battery.disabled = true;
        shell.disabled = false;
      };
    };
  };
}
