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

# Colorized terminal
It would be really good to make things automatically optimized for colorized output when I **KNOW** it is avaiable.
We can used non-colorized/default configs when we do not know that colorized output is avaiable.

# Wcom
Need configuring.
Its hard to click
Maybe I can find a way to simulate touch inputs.
Connect with BT

# Passwords and secrets
Maybe what I can do is have my passwords and secrets protected by logging in.
1. Maybe I have enctypted passwords checkin to git and only logging in with a particual password into the user account
enables thos secrets to be decryped.

2. Maybe I have enctypted passwords managed out band of the home config and not in the repo. But I setup something so when I login
to my user account it can unlock something that can be more dynamicly quiried for passwords and secrets.

With (1) the passwords stay in sync and I dont have to worry about them getting out of sync. But I already have something for manageing passwords.
With (2) I need to put my encypted passwords for the world to read (even if they are enctypted, its considered a bad idea). But I cant rely on
being able to just download my home config and build it and everything just works. I think the process of having to log into everything once I setup a new
computer is a pain.

(2) Does not seem so bad, I would rather not have to update my home config everytime I want to update a password
(ontop of where I am typically sotring the password, and updating the actuall login). Also I would prob have to take a seprate step to gain access to my
passwords at somepoint for any of my systems that I need my passwords on.

# Lockscreen and desktop
I want to put pictues of my loved ones as my lock screen and desktop, but there is two major issues.
1. If I check in those images to this repo, then I will be making them public, I dont want to do that.
2. On my desktop and lockscreen (at least on sway) could be streemed in meetings to coworks, clients and colaborators
I want to keep things more profesional, not that its not okay or anything, just not my style to show my family to people I work with
without knowing them well enough, and I don't know if everyone who is going to see my desktop I will know well enough.

I see two steps I need to take to deal with these issues, both require a more dynamic approach to selecting a desktop background just
thowing it in the repo and pointing programs at it.
1. I need to a setup a private store for personal things like that, maybe a home server or I use a cloud, either way I need something I take
care of and keep long term, that goes into another project I have not been dealing with for a while.
2. I need to have a way to switch between one set of lockscreen and desktop images (public images) and another set of more private images.
I need a manual way of triggering the switch and I need something that automatically triggers when I start screen sharing.
(Maybe I can use the same kind of hook for automatically pausing my music or videos or something when my mic goes on, or I join a call... Maybe thats too much)

# safeeyes
Lock button does not work. I would like it to

# Notifcation when any long running command ends
I end up running a lot of long running commands. They tend to keep my focus or keep me from becoming totally focused on something else while they are running. If I had
a notifcation sound or show when any command that runs for more than X secconds finishes then I can forget about any command after X secconds that I watch it run.
