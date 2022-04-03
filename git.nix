{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    radicle-upstream
  ];

  programs = {
    git = {
      enable = true;
      userName = "Rosario Pulella";
      userEmail = "RosarioPulella@gmail.com";

      extraConfig = {
        diff.tool = "vimdiff";
        difftool.prompt = false;

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
