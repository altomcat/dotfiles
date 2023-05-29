GUIX_PROFILE="/home/$USER/.guix-profile"
. "$GUIX_PROFILE/etc/profile"

if [ -n "$WAYLAND_DISPLAY" ]; then
    xinput set-prop 12 "libinput Middle Emulation Enabled" 1
fi

# retrieve proxy authentification
if [ -f ~/.proxy ]; then . ~/.proxy; fi

# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

#fix rendering bugs with github and other websites
alias qutebrowser='QTWEBENGINE_CHROMIUM_FLAGS="--disable-seccomp-filter-sandbox" qutebrowser'

# define default text editor for awesome wm
export EDITOR='emacsclient -c -a ""'

