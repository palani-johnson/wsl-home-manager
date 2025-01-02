{ pkgs, ... }: 
let 
  sessionVariables = {
    EDITOR = "code";
  };
in {
  home = {
    enableNixpkgsReleaseCheck = false; # DISABLE ONE DAY
    stateVersion = "24.05";
    username = "nixos";
    homeDirectory = "/home/nixos";
    sessionVariables = sessionVariables;
    preferXdgDirectories = true;

    packages = [
      pkgs.nil
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
    
    git = {
      enable = true;
      userName = "Palani Johnson";
      userEmail = "palanijohnson@gmail.com";
      extraConfig.init.defaultBranch = "main";
    }; 
    
    nushell = {
      enable = true;
      extraConfig = builtins.readFile ./nushell/config.nu;
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";

        battery.disabled = true;
      };
    };
    
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}