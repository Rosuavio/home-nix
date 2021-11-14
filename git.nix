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
    };

    gh = {
      enable = true;

      gitProtocol = "ssh";
    };
  };
}
