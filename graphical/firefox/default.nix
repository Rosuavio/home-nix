{ lib, pkgs, ... }:
let
  addons = import addons/defualt.nix {
    inherit lib;

    fetchurl = pkgs.fetchurl;
    stdenv = pkgs.stdenv;
  };

  browser = "firefox.desktop";
in
{
  programs.firefox = {
    enable = true;

    package = pkgs.firefox-wayland;

    profiles.Rosario = {
      id = 0;
      isDefault = true;
      settings = {
        "extensions.autoDisableScopes" = 0;
        "extensions.update.enable" = false;
        "extensions.enabledScopes" = 15;
      };

      # TODO: Map all attrs to a list.
      extensions = [
        addons.bitwarden
        addons.noscript
        addons.stylus
      ];
    };
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http"      = [ browser ];
    "x-scheme-handler/https"     = [ browser ];
    "x-scheme-handler/about"     = [ browser ];
    "x-scheme-handler/unknown"   = [ browser ];
  };
}
