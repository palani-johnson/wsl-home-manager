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
      # nix
      nixd
      alejandra

      # python
      (python3.withPackages (p: with p; [ipykernel]))
      ruff

      # node
      nodejs
      nodePackages.prettier
    ];
  };

  xdg.enable = true;

  programs = {
    home-manager.enable = true;

    # mostly used for completions
    fish = {
      enable = true;
      generateCompletions = true;
    };

    zsh = {
      enable = true;
      sessionVariables = sessionVariables;
      dotDir = ".config/zsh";
      history.path = "$HOME/.cache/zsh/history";
      initExtra = builtins.readFile ./zsh/initExtra.zsh;
      enableCompletion = true;
      prezto.enable = true;
    };

    nushell = {
      enable = true;
      extraConfig = builtins.readFile ./nushell/extraConfig.nu;
    };

    git = {
      enable = true;
      userName = "Palani Johnson";
      userEmail = "palanijohnson@gmail.com";

      extraConfig = {
        init.defaultBranch = "main";
        core.pager = "cat";
      };
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";

        format = "$username$hostname$directory$git_branch$git_state$git_status$nix_shell$cmd_duration$line_break$sudo$status$shell$character";

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
      config = {
        global.warn_timeout = "1m";
        whitelist.prefix = [
          "~/Projects"
        ];
      };
    };
  };
}
