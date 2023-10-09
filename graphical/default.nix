{pkgs, config, ...}:
{
  imports = [
    ./theming.nix
    ./services.nix
    ./sway.nix
    ./firefox
    ./vscode.nix
    ./messaging.nix
  ];

  home.sessionVariables = {
    USER_ENTRY = "${config.home.profileDirectory}/bin/sway";
  };

  home.packages = with pkgs; [
    epiphany

    okular
    spotify
    bitwarden
    libreoffice

    grim slurp
    imv
    wl-clipboard

    dbeaver
  ];

  xdg.mimeApps.defaultApplications = {
    "x-sheam-handler/bitwarden" = [ "Bitwarden.desktop" ];
  };

  programs = {
    foot.enable = true;
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };

    chromium = {
      enable = true;
      package = pkgs.brave;
    };

    obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.wlrobs ];
    };
  };

}
