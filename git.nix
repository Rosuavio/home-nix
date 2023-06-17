{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    difftastic
  ];

  programs = {
    git = {
      enable = true;
      userName = "Rosario Pulella";
      userEmail = "RosarioPulella@gmail.com";

      extraConfig = {
        diff.tool = "difftastic";
        difftool.prompt = false;
        difftool.difftastic.cmd = ''${lib.getExe pkgs.difftastic} "$LOCAL" "$REMOTE"'';

        mergetool.prompt = false;
        merge = {
          tool = "vimdiff";
          conflictstyle = "diff3";
        };

        init.defaultBranch = "main";
      };

      lfs.enable = true;
    };

    gh = {
      enable = true;

      settings = {
        git_protocol = "ssh";
        editor = "kak";
      };
    };
  };
}
