#!/usr/bin/env bash

if [[ ! -f ~/.tmux/plugins/tpm/bin/install_plugins ]]; then
  echo "Cloning TPM to '~/.tmux/plugins/tpm'"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm >/dev/null
fi
echo "Getting '.tmux.conf' from Repo"
curl -sSL https://raw.githubusercontent.com/Xenion1987/my-personal-settings-collection/main/global/tmux/.tmux.conf -o ~/.tmux.conf
echo "Install TMUX plugins"
tmux new-session -d -s install_plugins '~/.tmux/plugins/tpm/bin/install_plugins'
echo "Customize tmux-powerline"
mkdir -p ~/.config/tmux/plugins
if [[ ! -d ~/.config/tmux-powerline ]] && [[ ! -L ~/.config/tmux-powerline ]]; then
  ln -s ~/.tmux/plugins/tmux-powerline ~/.config/tmux-powerline
fi
if [[ ! -d ~/.config/tmux/plugins/tmux-powerline ]] && [[ ! -L ~/.config/tmux/plugins/tmux-powerline ]]; then
  ln -s ~/.tmux/plugins/tmux-powerline ~/.config/tmux/plugins/tmux-powerline
fi
~/.config/tmux/plugins/tmux-powerline/generate_rc.sh
mv -v ~/.config/tmux-powerline/config.sh.default ~/.config/tmux-powerline/config.sh
cp -av ~/.config/tmux-powerline/themes/{default,my-theme}.sh
sed -r -i 's/TMUX_POWERLINE_THEME="([a-zA-Z0-9_-]+)"$/TMUX_POWERLINE_THEME="my-theme"/' ~/.config/tmux-powerline/config.sh

DEACTIVATE_SEGMENTS=(vcs_branch pwd now_playing battery weather)
for DEACTIVATE_SEGMENT in "${DEACTIVATE_SEGMENTS[@]}"; do
  sed -r -i 's/^(\s*)"'"${DEACTIVATE_SEGMENT}"' ([0-9]+ [0-9]+)"/\1#"'"${DEACTIVATE_SEGMENT}"' \2"/' ~/.config/tmux-powerline/themes/my-theme.sh
done
RC_FILES=(.bashrc .zshrc)
for RC_FILE in "${RC_FILES[@]}"; do
  if [[ -s "${HOME}/${RC_FILE}" ]]; then
    if ! grep -q '### ADDED BY XENION1987' "${HOME}/${RC_FILE}"; then
      cat <<_EOF >>"${HOME}/.bashrc"
### ADDED BY XENION1987
files=(.aliases .functions .paths)
for file in "\${files[@]}"; do
  if [[ ! -f "\${HOME}/\${file}" ]]; then
    touch "\${HOME}/\${file}"
  else
    source "\${HOME}/\${file}"
  fi
done
###

_EOF
    fi
  fi
done
