let

  sources = import ./nix/sources.nix;

  nixpkgs = sources."nixpkgs";

  pkgs = import nixpkgs {};

  foo = pkgs.writeShellScriptBin "foo" "";

in pkgs.mkShell rec {

  name = "home-manager-shell";

  buildInputs = with pkgs; [
    niv
    (import sources.home-manager {inherit pkgs;}).home-manager
    (import sources.nur-combined {inherit pkgs;}).repos.rycee.firefox-addons-generator
    foo
  ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs}:home-manager=${sources."home-manager"}"
    export HOME_MANAGER_CONFIG="./home.nix"
  '';

}
