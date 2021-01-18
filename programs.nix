{pkgs, ...}:

{
  programs = {
    bash.enable = true;
    bat.enable = true;
    ssh.enable = true;

    mako = {
      enable = true;
      defaultTimeout = 1000 * 5;
      anchor = "bottom-right";
    };

    rofi = {
      enable = true;
    };

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

    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        stylus
        bitwarden
      ];

      profiles.Rosario = {
        id = 0;
        isDefault = true;
      };
    };
  };
}
