#!/data/data/com.termux/files/usr/bin/env bash
# SPDX-License-Identifier: 0BSD
# Customize termux
set -e

setup_pacman() {
  local pacman_conf pacman_conf='https://raw.githubusercontent.com/huinya456/tqs/main/cfg'
  pacman_conf="${pacman_conf}/usr/etc/pacman.conf"
  curl -f -o "${PREFIX}/etc/pacman.conf" "${pacman_conf}"
  pacman-key --init
  pacman-key --populate
  pacman -S bsdtar zsh micro openssh git python man file --noconfirm
  pacman -Rsn nano command-not-found --noconfirm
}

main() {
  setup_pacman
  local tmp="${PREFIX}/tmp/tqs"
  local id
  id="$(id -u)"
  bsdtar --uid "${id}" --gid "${id}" -x -f "${tmp}/cfg.tar" -C "${TERMUX__ROOTFS_DIR}"
  chsh -s zsh
  echo 'Done'
}

main
