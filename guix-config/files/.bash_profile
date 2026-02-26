GUIX_PROFILE="$HOME/.guix-profile"
. "$GUIX_PROFILE/etc/profile"

GUIX_PROFILE="$HOME/.config/guix/current"
. "$GUIX_PROFILE/etc/profile"

# retrieve proxy authentification
if [ -f ~/.proxy ]; then . ~/.proxy; fi
