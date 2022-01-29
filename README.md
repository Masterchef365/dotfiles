# My dotfiles
Feel free to copy, redistribute, whatever. I'd recommend installing them using GNU Stow, like so:
```
stow */
```
How cool is that?

## Ideapad
From https://wiki.archlinux.org/title/Laptop/Lenovo#IdeaPad

Modify `/etc/default/grub`:
```
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet i8042.direct i8042.dumbkbd i915.enable_psr=0"
```

## Connman
### Disallowing annoying hostname updates
From https://wiki.archlinux.org/title/ConnMan#Avoid_changing_the_hostname

Edit `/etc/connman/main.conf`:
```
[General]
AllowHostnameUpdates = false
```

### Eduroam
From https://wiki.archlinux.org/title/ConnMan#Connecting_to_eduroam_(802.1X)

Create `/var/lib/connman/eduroam.config`:
```
[service_eduroam]
Type=wifi
Name=eduroam
EAP=peap
Phase2=MSCHAPV2
Identity=<OSU email>
Passphrase=<OSU password>
```

## Pulseaudio
Enable using:
```sh
systemctl --user enable pulseaudio
```

## Intel graphics tearing
From: https://wiki.archlinux.org/title/Intel_graphics#Tearing

Create `/usr/share/X11/xorg.conf.d/20-intel.conf`:
```
Section "Device"
  Identifier "Intel Graphics"
  Driver "intel"
  Option "TearFree" "true"
EndSection
```

## Lock on wake
Add the following SystemD service:

`systemctl edit --force --full wakelock.service`

```
[Unit]
Description=Lock the screen on resume from suspend
Before=sleep.target
Before=suspend.target

[Service]
User=duncan
Type=forking
Environment=DISPLAY=:0
ExecStart=/usr/bin/i3lock-fancy -p

[Install]
WantedBy=sleep.target
WantedBy=suspend.target
```
