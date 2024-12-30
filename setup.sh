#!/usr/bin/env bash

set -eu

apt-get update
apt-get install -y htop mg rsync tmux

cat <<EOF > /root/.mg
make-backup-files
column-number-mode
EOF

cat <<EOF > /home/admin/.mg
make-backup-files
column-number-mode
EOF

cat <<EOF > /home/admin/.tmux.conf
unbind C-b
set -g prefix C-u
bind C-u send-prefix
set -g mouse on
set -g default-terminal "xterm-256color"
set -g history-limit 1000000
EOF

chown admin:admin /home/admin/.mg
chown admin:admin /home/admin/.tmux.conf
