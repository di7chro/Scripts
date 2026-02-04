#!/bin/bash

# Placera scriptet i /bin på en Debian-server

set -e

# ===== FÄRGER =====
GREEN="\e[32m"
RESET="\e[0m"

info() {
  echo -e "${GREEN}$1${RESET}"
}

# ===== SÄKERHET =====
if [ "$EUID" -ne 0 ]; then
  echo "Detta script måste köras som root."
  exit 1
fi

info "=== Systemunderhåll startar ==="

info "Uppdaterar paketlistor..."
apt update

info "Uppgraderar systemet (full-upgrade)..."
apt full-upgrade -y

info "Tar bort onödiga paket..."
apt autoremove --purge -y

info "Rensar paketcache..."
apt clean

info "Tar bort gamla kärnor..."
current_kernel=$(uname -r)
info "Aktiv kärna: $current_kernel"

dpkg -l 'linux-image-*' \
  | awk '/^ii/{ print $2 }' \
  | grep -v "$current_kernel" \
  | xargs -r apt purge -y

info "Uppdaterar grub..."
update-grub

# ===== OMSTART =====
if [ -f /var/run/reboot-required ]; then
  info "⚠ Systemet behöver startas om."
fi

info "=== Systemunderhåll klart ==="