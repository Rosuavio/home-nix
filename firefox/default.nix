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
    };

    # TODO: Map all attrs to a list.
    extensions = [
      addons.redux-devtools
      addons.bitwarden
      addons.noscript
      addons.stylus
      addons.react-devtools
      addons.plasma-integration
      addons.ipfs-companion
    ];
  };

  xdg.mimeApps.defaultApplications = {
    "text/html"                  = [ browser ];
    "x-scheme-handler/http"      = [ browser ];
    "x-scheme-handler/https"     = [ browser ];
    "x-scheme-handler/about"     = [ browser ];
    "x-scheme-handler/unknown"   = [ browser ];
  };
}
