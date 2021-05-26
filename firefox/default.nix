{ lib, pkgs, ... }:
let
  addons = import addons/defualt.nix {
    inherit lib;

    fetchurl = pkgs.fetchurl;
    stdenv = pkgs.stdenv;
  };

  browser = "firefox";
in
{
  programs.firefox = {
    enable = true;

    # There if some more depth in the firefox package.
    # the firefox-wayland package just has the ff package with some wayland forced flag
    # from nixpkgs there seems to be a way that ff can be built with more wayland stuff and pipwire stuff
    # if its enbled in nixos system config. Home manager cannot see what nixos is configured like so I need a way
    # to detect and if wayland and pipewire are avaible and flip the right build switches for home-manager ff.
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
