{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    gitAndTools.gh

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
      };
    };
  };
}
