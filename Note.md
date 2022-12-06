
> This should rather be an option, as sometime you want to get out of the nix-shell to edit it and debug it.

Perhaps it should be an option. Personally I think it should be the default behavior and maybe the project as a whole should behave like `nix-shell --run "code ."`

From the Readme.
> One option is to run `nix-shell` on the command line and then launch `code` within the activated shell. However, this process can quickly become tedious. `Nix Environment Selector` provides an alternative: can automatically apply the environment.

The project seems to present its self as a more convenient alternative to opening a terminal and running `nix-shell --run "code ."`, and as a user I felt I need **exactly** that. That would allow me to enjoy vscode's with out having to constantly launch a terminal. 