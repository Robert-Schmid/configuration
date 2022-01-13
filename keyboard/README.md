## Info

Very small keyboard layout change to the us+de_se_fi layout

To select in gnome open gnome-tweaks and allow additional input sources in the keyboard section.


## Changes

Removed the <MENU> alias in /usr/share/X11/xkb/keycodes/evdev

Changed the <COMP> config to be a second SUPER_L in /usr/share/X11/xkb/symbols/us

Rational: My keyboard doesn't have a right super, but a useless menu key.
This changes the menu key to a second left super.
Left super is the super key for my gnome session which make switching desktops easier by having a super key near page-up/down and the arrow keys.
