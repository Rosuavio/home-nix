# My home-manager conf
This repo only depends on nix, the shell.nix file pulls in everything else.
To use any of the tools run `nix-shell` in the root of the dir. The nix-shell env pulls in a few tools.

1. [home-manager](https://nix-community.github.io/home-manager/) for managing home dir configurations.
2. [npins](https://github.com/andir/npins) for managing nix dependencies.
3. [pkgs-firefox-addons](https://github.com/nix-community/nur-combined/blob/a6b479f122696aee99dadfe060745efa717259a9/repos/rycee/pkgs/firefox-addons-generator/default.nix) from the Nix User repository.

> **TODO:** source pkgs-firefox-addons from https://gitlab.com/rycee/nixpkgs-firefox-addons

# Go To Commands

To enter the development shell and get access to all the tools necessary.
```sh
nix-shell
```

To update home dir based off home conf use
```sh
home-manager switch
```

To update nix dependencies
```sh
npins update
```

To update firefox addons
```sh
nixpkgs-firefox-addons firefox/addons/addons.json firefox/addons/generated-firefox-addons.nix
```

> **TODO:** consolidate updating to one update script.

# Other
I got a [TODO](TODO.md) going.
