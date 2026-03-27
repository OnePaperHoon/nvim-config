#!/usr/bin/env bash
set -euo pipefail

TMUX_CONF="${HOME}/.tmux.conf"
TPM_DIR="${HOME}/.tmux/plugins/tpm"
BACKUP_SUFFIX="$(date +%Y%m%d_%H%M%S)"

BASIC_START="# >>> nvim-tmux basic config >>>"
BASIC_END="# <<< nvim-tmux basic config <<<"

PLUGIN_START="# >>> tmux plugin config >>>"
PLUGIN_END="# <<< tmux plugin config <<<"

BASIC_BLOCK=$(cat <<'EOF'
# >>> nvim-tmux basic config >>>
set -g mouse on
set -g history-limit 100000
set -g base-index 1
setw -g pane-base-index 1
set -g renumber-windows on

bind-key -n C-h select-pane -L
bind-key -n C-j select-pane -D
bind-key -n C-k select-pane -U
bind-key -n C-l select-pane -R
bind-key -n C-\ last-pane
# <<< nvim-tmux basic config <<<
EOF
)

PLUGIN_BLOCK=$(cat <<'EOF'
# >>> tmux plugin config >>>
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

set -g @continuum-restore 'on'
set -g @resurrect-capture-pane-contents 'on'

run '~/.tmux/plugins/tpm/tpm'
# <<< tmux plugin config <<<
EOF
)

require_cmd() {
  local cmd="$1"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: '$cmd' is not installed."
    exit 1
  fi
}

backup_tmux_conf() {
  if [[ -f "$TMUX_CONF" ]]; then
    cp "$TMUX_CONF" "${TMUX_CONF}.bak.${BACKUP_SUFFIX}"
    echo "Backup created: ${TMUX_CONF}.bak.${BACKUP_SUFFIX}"
  fi
}

remove_block() {
  local start="$1"
  local end="$2"

  if [[ -f "$TMUX_CONF" ]] && grep -qF "$start" "$TMUX_CONF"; then
    awk -v start="$start" -v end="$end" '
      $0 == start { skip=1; next }
      $0 == end   { skip=0; next }
      !skip
    ' "$TMUX_CONF" > "${TMUX_CONF}.tmp"
    mv "${TMUX_CONF}.tmp" "$TMUX_CONF"
  fi
}

append_block() {
  local block="$1"
  touch "$TMUX_CONF"
  {
    echo
    echo "$block"
    echo
  } >> "$TMUX_CONF"
}

install_or_update_tpm() {
  mkdir -p "${HOME}/.tmux/plugins"

  if [[ -d "$TPM_DIR/.git" ]]; then
    git -C "$TPM_DIR" pull --ff-only
    echo "TPM updated."
  else
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo "TPM installed."
  fi
}

reload_tmux_if_running() {
  if tmux info >/dev/null 2>&1; then
    tmux source-file "$TMUX_CONF"
    echo "tmux config reloaded."
    echo "Inside tmux, press Prefix + I to install plugins."
  else
    echo "tmux server is not running."
    echo "Start tmux later, then press Prefix + I to install plugins."
  fi
}

main() {
  require_cmd git
  require_cmd tmux

  backup_tmux_conf

  remove_block "$BASIC_START" "$BASIC_END"
  remove_block "$PLUGIN_START" "$PLUGIN_END"

  append_block "$BASIC_BLOCK"
  append_block "$PLUGIN_BLOCK"

  install_or_update_tpm
  reload_tmux_if_running

  echo
  echo "Done."
  echo "Written: $TMUX_CONF"
  echo "Next step:"
  echo "  1. Start tmux"
  echo "  2. Press Prefix + I"
  echo "     - default Prefix is Ctrl-b"
  echo "  3. Restart tmux if needed"
}

main "$@"