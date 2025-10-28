#!/bin/bash

# Get current session name
current_session=$(tmux display-message -p '#S')

# Get the most recently attached session that's not the current one
target_session=$(tmux list-sessions -F '#{session_last_attached} #{session_name}' | \
    sort -rn | \
    awk -v current="$current_session" '$2 != current {print $2; exit}')

# If we found a target session, switch to it
if [ -n "$target_session" ]; then
    tmux switch-client -t "$target_session"
else
    tmux display-message "No other session to switch to"
fi
