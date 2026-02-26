# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]]
then
    # We are being invoked from a non-interactive shell.  If this
    # is an SSH session (as in "ssh host command"), source
    # /etc/profile so we get PATH and other essential variables.
    [[ -n "$SSH_CLIENT" ]] && source /etc/profile

    # Don't do anything else.
    return
fi

# Source the system-wide file.
source /etc/bashrc

# Adjust the prompt depending on whether we're in 'guix environment'.
if [ -n "$GUIX_ENVIRONMENT" ]
then
    PS1='\u@\h \w [env]\$ '
else
    PS1='\u@\h \w\$ '
fi

# Activate direnv
(command -v direnv) > /dev/null && eval "$(direnv hook bash)"

alias ls='ls -p --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'
alias vi=vim
alias update-system='sudo guix system -L ~/.dotfiles reconfigure ~/dotfiles/guix-config/systems/$(hostname).scm'
alias update-home='guix home -L ~/.dotfiles reconfigure ~/.dotfiles/guix-config/home/home-config.scm'

alias qutebrowser='QTWEBENGINE_CHROMIUM_FLAGS="--disable-seccomp-filter-sandbox" qutebrowser'
alias qemu="qemu-system-x86_64 -enable-kvm -m 512"

export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
export SSL_CERT_DIR="$HOME/.guix-profile/etc/ssl/certs"
export SSL_CERT_FILE="$HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt"
export GIT_SSL_CAINFO="$SSL_CERT_FILE"
export QT_QPA_PLATFORM=wayland

$(command -v fastfetch > /dev/null) && fastfetch

if [[ "$HOSTNAME" == "exegol"  &&  "$(tty)" == "/dev/tty1" ]]
then
    dbus-run-session sway
fi
