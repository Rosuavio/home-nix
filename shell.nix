let

  sources = import ./npins;
  pkgs = import sources.nixpkgs-unstable {};
  nur = import sources.nur-combined { inherit pkgs; };

in pkgs.mkShell rec {
  name = "home-dev";

  packages = [
    pkgs.git
    pkgs.npins
    nur.repos.ethancedwards8.firefox-addons-generator
  ];

  shellHook = ''
    echo 'Welcome to the home development shell!'
  '';
}
