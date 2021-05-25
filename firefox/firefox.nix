{ lib, pkgs, fetchurl, stdenv, ... }:
let
  buildFirefoxXpiAddon = import ./buildFirefoxXpiAddon.nix {
    inherit fetchurl stdenv;
  };

  extensions = import ./addons.nix {
    inherit buildFirefoxXpiAddon lib;
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

      # WORKAROUND: This forces the profile folder to be created fix in https://github.com/nix-community/home-manager/pull/2035
      settings = {
          "browser.startup.homepage"= "https://nixos.org";
      };
    };

    # extensions = builtins.map  { inherit buildFirefoxXpiAddon; };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html"                  = [ browser ];
    "x-scheme-handler/http"      = [ browser ];
    "x-scheme-handler/https"     = [ browser ];
    "x-scheme-handler/about"     = [ browser ];
    "x-scheme-handler/unknown"   = [ browser ];
  };
}
