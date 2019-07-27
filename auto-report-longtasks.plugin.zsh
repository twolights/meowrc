# Plugin that automatically reports when a long task is done
# Reference: https://github.com/popstas/zsh-command-time

_command_preexec() {
    timer=${timer:-$SECONDS}
}

_command_precmd() {
    if [ $timer ]; then
        threshold=${AUTO_REPORT_LONGTASKS_THRESHOLD:-120}
        time_last_command=$(($SECONDS - $timer))
        if [ $time_last_command -ge $threshold ]; then
            last_command=`fc -ln -1`
            slack-notify.sh "Last long task ($last_command) just finished"
        fi
        unset timer
    fi
}

precmd_functions+=(_command_precmd)
preexec_functions+=(_command_preexec)
