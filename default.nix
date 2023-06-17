{ sources ? import ./nix/sources.nix
, nixpkgs ? sources."nixos-23.05"
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

     home-manager ? home-manager-path,
   }:
   pkgs.writeShellScriptBin "home-manager" ''
     exec $HOME/.nix-profile/bin/home-manager \
       -A "${home-attribute}" \
       -I nixpkgs=${nixpkgs} \
       -I home-manager=${home-manager} \
       --file ${home-config-path} \
       "$@"
   '';
}
