#!/bin/bash

# Remember: ctrl+b to escape, :kill-session to exit. It's like vim, kind of!
# Other useful shortcuts
# ctrl-b z - full screen pane
# ctrl-b <arrow keys> move between panes
# ctrl-b n/p - next tab/previous tab

# Requires these in ~/.profile or ~/.bashrc
#export MASTER="xx.xx.xx.xx"
#export PARIS="xx.xx.xx.xx"
#export CALIFORNIA="xx.xx.xx.xx"
#export SYDNEY="xx.xx.xx.xx"
#export TOKYO="xx.xx.xx.xx"
#export CAPETOWN="xx.xx.xx.xx"
#export RCON_PASSWORD="xxxxxxxx"

tmux new-session -s 'quake3' \; \
  set -g pane-border-format "#{pane_index}:#{pane_title}" \; \
  set -g pane-border-status top \; \
  set -g mouse on \; \
  bind-key -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy" \; \
  set-option repeat-time 0 \; \
  rename-window -t quake3:0 coredev \; \
  send-keys 'printf '"'"'\033]2;Main Template\033\\'"'"' ' C-m \; \
  send-keys 'echo vim template.yml' C-m \; \
  split-window -h \; \
  send-keys 'printf '"'"'\033]2;Europe server\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${PARIS}" C-m \; \
  new-window -n 'master' \; \
  send-keys 'printf '"'"'\033]2;Master Template\033\\'"'"' ' C-m \; \
  send-keys 'echo vim master.yml' C-m \; \
  split-window -h \; \
  send-keys 'printf '"'"'\033]2;Master server\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${MASTER}" C-m \; \
  new-window -n 'rcon AU&AF' \; \
  send-keys 'printf '"'"'\033]2;SSH AU\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${SYDNEY}" C-m \; \
  split-window -v \; \
  send-keys 'printf '"'"'\033]2;SSH AF\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${CAPETOWN}" C-m \; \
  split-window -h \; \
  send-keys 'printf '"'"'\033]2;RCON AF 0\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${CAPETOWN} icecon 127.0.0.1:27960 \"${RCON_PASSWORD}\"" C-m \; \
  split-window -h \; \
  send-keys 'printf '"'"'\033]2;RCON AF 1\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${CAPETOWN} icecon 127.0.0.1:27961 \"${RCON_PASSWORD}\"" C-m \; \
  select-pane -t 0 \; \
  split-window -h \; \
  send-keys 'printf '"'"'\033]2;RCON AU 0\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${SYDNEY} icecon 127.0.0.1:27960 \"${RCON_PASSWORD}\"" C-m \; \
  split-window -h \; \
  send-keys 'printf '"'"'\033]2;RCON AU 1\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${SYDNEY} icecon 127.0.0.1:27961 \"${RCON_PASSWORD}\"" C-m \; \
  new-window -n 'rcon US&UK' \; \
  send-keys 'printf '"'"'\033]2;SSH EU\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${PARIS}" C-m \; \
  split-window -v \; \
  send-keys 'printf '"'"'\033]2;SSH US\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${CALIFORNIA}" C-m \; \
  split-window -h \; \
  send-keys 'printf '"'"'\033]2;RCON US 0\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${CALIFORNIA} icecon 127.0.0.1:27960 \"${RCON_PASSWORD}\"" C-m \; \
  split-window -h \; \
  send-keys 'printf '"'"'\033]2;RCON US 1\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${CALIFORNIA} icecon 127.0.0.1:27961 \"${RCON_PASSWORD}\"" C-m \; \
  select-pane -t 0 \; \
  split-window -h \; \
  send-keys 'printf '"'"'\033]2;RCON EU 0\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${PARIS} icecon 127.0.0.1:27960 \"${RCON_PASSWORD}\"" C-m \; \
  split-window -h \; \
  send-keys 'printf '"'"'\033]2;RCON EU 1\033\\'"'"' ' C-m \; \
  send-keys "ssh ec2-user@${PARIS} icecon 127.0.0.1:27961 \"${RCON_PASSWORD}\"" C-m \; \
