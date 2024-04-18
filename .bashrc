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

# Customize prompt.
LightGreen="\e[1;32m"
LightBlue="\e[1;34m"
Normal="\e[0m"

# Return the current branch
get_git_branch() {
    result=$(git branch --show-current 2> /dev/null)
    if [ -n "$result" ]; then
	echo -e " ("$LightGreen$result$Normal") "
    fi
}

# Return where HEAD points to
get_git_HEAD() {
    result=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [ -n "$result" ]; then
	echo -e $LightBlue"HEAD ⤘"$Normal" "$LightGreen$result$Normal
    fi
}

# Adjust the prompt depending on whether we're in 'guix environment'.
if [ -n "$GUIX_ENVIRONMENT" ]
then
    PS1='\u@\h \w [env]`get_git_branch``get_git_HEAD` 🧞 '
else
    PS1='\u@\h \w`get_git_branch``get_git_HEAD` 🧞 '
fi
