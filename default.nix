{ sources ? import ./nix/sources.nix
, nixpkgs ? sources."nixos-22.11"
, home-manager ? sources.home-manager
, ...
}:
let
  nixpkgs-path = nixpkgs;
  home-manager-path = home-manager;
in
{
  mkHomeScriptWrapper =
   {
     # Path to user defined home-manager specific configuration
     home-config-path,

     # Name of attribute in the attribute set in home-config-path to use as the
     # root attribute set for home-manager configuration
     # When empty string - uses attribute set in home-config-path as root
     home-attribute ? "",

     # Path to nixpkgs used by home-manager modules
     nixpkgs ? nixpkgs-path,

     # Package set for building the home-manager cli and this wrapper
     pkgs ? import nixpkgs { },

     # Path to home-manager moudles used by the home-manager cli
     # Avaible options from home-manager are sourced from here.
     home-manager ? home-manager-path,

     # Path to the home-manager cli derivation
     home-manager-script-path ? home-manager + "/home-manager",

     # home-manager tool that gets wrapped
     home-manager-script ? pkgs.callPackage home-manager-script-path
      {
        # Primary default path for home-manager repo for home-manager script to
        # use. This can be used to adjust the version of the repo that is built
        # by nix.
        path = home-manager;
      }
   }:
   pkgs.writeShellScriptBin "home-manager" ''
     exec ${home-manager-script}/bin/home-manager \
       -A "${home-attribute}" \
       -I nixpkgs=${nixpkgs} \
       --file ${home-config-path} \
       "$@"
   '';
}
