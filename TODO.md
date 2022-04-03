# To Do
My config is getting there but there is always work to do

## Brightness/Volume
human scaling.

## Kakoune
https://github.com/mawww/kakoune


## Firefox
Got my extensions, had to enable them in ff though.
Want to build my extensions from source, ?and have the sources update with niv like everything else?
I still want no script...

Got an update tool to update the sources from moz, I am using those sources in nix and installing them on home-manager switch.

But I am not getting them from the source repos. I am getting compiled packages from moz.

## xmonad
I want to use xmoand, seems like it would be cool, useful.
Also maybe I could pull in some tools like hls to help make it easer to work on.

## plasma
I would like to manage more of the my plasma config threw hm.

## User generated de+wm sessions
No clue how to do this, but I would love to have all the of the de+wm config manageable threw hm. All the binaries (or as much as possible) come from the hm conf. So that any user can completely control there env from the moment they login.
The login manager would need to detect this config in the users dir.

Also the os config would need to provide default envs and tools for new users.

# HLS
See if it makes sense to set up hls in home-manger rather than just in dev shells.

# Git-lfs
It seems like git-lfs only uses http(s) or something https://stackoverflow.com/questions/42429028/git-lfs-asking-for-passphrase-for-every-tracked-file
and this causes `git clone` to keep asking for ssh passphrase, like 20 times. Very annoying. 

I can just use some kind of cred cacher or something. Or maybe I can rase/fix the issue upstream. git/git-lfs/home-manager/nixos?

I can either be involved in fixing git/git-lfs or change default configs in home-manager or nixos.
