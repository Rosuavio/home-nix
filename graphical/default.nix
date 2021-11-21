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
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
    iconTheme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "Breeze-Dark";
      package = pkgs.LibsForQt5.breeze;
    };
  };

  home.packages = with pkgs; [
    epiphany

    okular
    spotify
    bitwarden
    libreoffice
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
  };

  services.wlsunset = {
    enable = true;
    latitude = "28.636591";
    longitude = "-81.371088";
  };
}
