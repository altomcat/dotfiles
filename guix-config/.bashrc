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
[ -f /etc/bashrc ] && source /etc/bashrc

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
# fix rendering bugs with github and other websites
alias qutebrowser='QTWEBENGINE_CHROMIUM_FLAGS="--disable-seccomp-filter-sandbox" qutebrowser'
alias qemu="qemu-system-x86_64 -enable-kvm -m 512"

export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"

if [[ "$HOSTNAME" == "argiope"  &&  "$(tty)" == "/dev/tty1" ]]
then
    dbus-run-session sway
fi

