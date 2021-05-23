{pkgs, ...}:

{
  imports = [
    ./firefox/firefox.nix
  ];

  programs = {
    bash.enable = true;
    bat.enable = true;
    ssh.enable = true;

    vscode = {
      enable = true;
      package = pkgs.vscodium;
    };

    git = {
      enable = true;
      userName = "Rosario Pulella";
      userEmail = "RosarioPulella@gmail.com";

      extraConfig = {
        # core.editor = editor;
        diff.tool = "vimdiff";
        difftool.prompt = false;

        mergetool.prompt = false;
        merge = {
          tool = "vimdiff";
          conflictstyle = "diff3";
        };
      };
    };

    direnv = {
      enable = true;
      enableNixDirenvIntegration = true;
    };

    chromium = {
      enable = true;
      package = pkgs.brave;
    };
  };
}
