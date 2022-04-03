{pkgs, ...}:
{
  imports = [
    ./sway.nix
    ./firefox
    ./vscode.nix
    ./messaging.nix
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      name = "Adwaita-Dark";
      package = pkgs.adwaita-qt;
    };
  };

  home.packages = with pkgs; [
    epiphany

    okular
    spotify
    bitwarden
    libreoffice

    swaylock swayidle
    grim slurp
    imv
    wl-clipboard
  ];

  xdg.mimeApps.defaultApplications = {
    "x-sheam-handler/bitwarden" = [ "Bitwarden.desktop" ];
  };

  fonts.fontconfig.enable = true;

  programs = {
    foot.enable = true;
    mako = {
      enable = true;
      defaultTimeout = 10 * 1000;
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

  services.wlsunset = {
    enable = true;
    latitude = "28.636591";
    longitude = "-81.371088";
  };
}
