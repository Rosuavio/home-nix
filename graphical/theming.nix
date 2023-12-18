{ pkgs, ...}:
{
  fonts.fontconfig.enable = true;

  # I want to add more fonts, but currently hm does not provide a way to
  # configure default/prioratized fonts (or an extraConfig section).
  # So I if I add more fonts I cant control which ones get used by programs
  # See
  #   https://github.com/nix-community/home-manager/pull/2732
  #   https://github.com/nix-community/home-manager/pull/1268
  #   https://github.com/nix-community/home-manager/issues/2186
  home.packages = with pkgs; [
    hack-font
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
}
