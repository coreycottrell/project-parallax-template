#!/bin/bash
# ACG-Connect Onboarding Launcher
# Placeholders filled by onboarding server:
#   {{PROJECT_DIR}} - path to user's civ directory
#   {{SESSION_PREFIX}} - e.g., "user-lobster"
#   {{INITIAL_PROMPT}} - first message to Claude

PROJECT_DIR="{{PROJECT_DIR}}"
SESSION_PREFIX="{{SESSION_PREFIX}}"
INITIAL_PROMPT="{{INITIAL_PROMPT}}"

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
SESSION_NAME="${SESSION_PREFIX}-${TIMESTAMP}"

# Create logs directory
mkdir -p "${PROJECT_DIR}/logs"

# Write session name for external tools (do this early)
echo "${SESSION_NAME}" > "${PROJECT_DIR}/.current_session"

# Create tmux session and launch Claude
tmux new-session -d -s "${SESSION_NAME}" -c "${PROJECT_DIR}"
tmux send-keys -t "${SESSION_NAME}" "claude --dangerously-skip-permissions" C-m

# Wait for Claude to start, then inject the initial prompt with robust Enter
sleep 5
tmux send-keys -t "${SESSION_NAME}" -l "${INITIAL_PROMPT}"
sleep 0.2
tmux send-keys -t "${SESSION_NAME}" Enter
sleep 0.2
tmux send-keys -t "${SESSION_NAME}" Enter

# Open Windows Terminal tab and attach to the session
wt.exe -w 0 new-tab --title "${SESSION_PREFIX} ${TIMESTAMP}" wsl.exe -e tmux attach -t "${SESSION_NAME}"

# Output session name (captured by caller)
echo "${SESSION_NAME}"
