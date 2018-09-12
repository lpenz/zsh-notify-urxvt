#!/usr/bin/env zsh
#
# Copyright (C) 2018 Leandro Lisboa Penz <lpenz@lpenz.org>
# This file is subject to the terms and conditions defined in
# file 'LICENSE', which is part of this source code package.

[[ -o interactive ]] || return
zmodload zsh/datetime || { print "can't zmodload zsh/datetime" >&2; return }
autoload -Uz add-zsh-hook || { print "can't autoload add-zsh-hook!" >&2; return }

# Before running a command: save the command and the timestamp
function urxvtnotify_preexec {
    urxvtnotify_timestamp=$EPOCHREALTIME
    urxvtnotify_lastcmd="$1"
}

# Runs after executing a command: before showing the prompt
function urxvtnotify_precmd {
    if [ "$TERM" != "rxvt-256color" ] && [ "$TERM" != "screen-256color" ]; then
        # Support TERM "fixing"
        return
    fi
    local elapsed=$(( EPOCHREALTIME - urxvtnotify_timestamp ))
    if (( elapsed > 3 )); then
        if (( elapsed > 3600 )); then
            elapsedStr=$(TZ=GMT; strftime '%H:%M:%S' $(( int(rint(elapsed)) )))
        elif (( elapsed > 60 )); then
            elapsedStr=$(TZ=GMT; strftime '%M:%S' $(( int(rint(elapsed)) )))
        else
            typeset -F 2 elapsedStr
            elapsedStr=$elapsed
        fi
        local cmdbase=${urxvtnotify_lastcmd:gs/;/_}
        local cmdret=$?
        local icon=$'\u2714'
        if [ "$cmdret" != 0 ]; then
            icon=$'\u2718'
        fi
        local seq="\e]777;notify;${icon} $cmdbase;"
        seq+="$urxvtnotify_lastcmd\\\n"
        seq+="${icon} = $cmdret\\\n"
        seq+="\uf252 $elapsedStr\a"
        if [ -n "$TMUX" ]; then
            printf '\ePtmux;\e%s\e\\' "$(printf ${seq})"
        else
            printf "$seq"
        fi
    fi
}

# Setup initial timestamp and callbacks
urxvtnotify_timestamp=$EPOCHREALTIME
preexec_functions+=(urxvtnotify_preexec)
precmd_functions+=(urxvtnotify_precmd)
