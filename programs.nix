{
  programs = {
    home-manager.enable = true;
    bash.enable = true;
    fish.enable = true;
    starship.enable = true;
    bat.enable = true;
    ssh.enable = true;

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
      # enableNixDirenvIntegration = true;
    };

    firefox = {
      enable = true;

      profiles.Rosario = {
        id = 0;
        isDefault = true;
      };
    };
  };
}
