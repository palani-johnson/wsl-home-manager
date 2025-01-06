{pkgs, ...}: let
  sessionVariables = {
    EDITOR = "code";
  };
in {
  home = {
    stateVersion = "24.11";
    username = "nixos";
    homeDirectory = "/home/nixos";
    sessionVariables = sessionVariables;
    preferXdgDirectories = true;

    packages = with pkgs; [
      nixd
      alejandra
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
      initExtra = builtins.readFile ./zsh/initExtra.zsh;
    };

    nushell = {
      enable = true;
      extraConfig = builtins.readFile ./nushell/extraConfig.nu;
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

        format = "$username$hostname$directory$fill$git_branch$git_state$git_status$nix_shell$cmd_duration$line_break$sudo$status$shell$character";

        fill.disabled = false;
        fill.symbol = " ";
        shell.disabled = false;
        cmd_duration.format = "[$duration]($style) ";
        git_branch.format = "[$symbol$branch(:$remote_branch)]($style) ";
        nix_shell.format = "[ $name]($style) ";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      silent = true;
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
  };
}
