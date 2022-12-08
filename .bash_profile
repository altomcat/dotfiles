GUIX_PROFILE="/home/altomcat/.guix-profile"
. "$GUIX_PROFILE/etc/profile"

xinput set-prop 12 "libinput Middle Emulation Enabled" 1

# retrieve proxy authentification
if [ -f ~/.proxy ]; then . ~/.proxy; fi

# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
