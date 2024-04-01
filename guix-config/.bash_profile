GUIX_PROFILE="$HOME/.guix-profile"
. "$GUIX_PROFILE/etc/profile"

GUIX_PROFILE="$HOME/.config/guix/current"
. "$GUIX_PROFILE/etc/profile"

if [ -n "$WAYLAND_DISPLAY" ]; then
    xinput set-prop 12 "libinput Middle Emulation Enabled" 1
fi

# retrieve proxy authentification
if [ -f ~/.proxy ]; then . ~/.proxy; fi

