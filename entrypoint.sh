#!/bin/bash
set -o nounset
set -o pipefail

PKGDIR="$1"
mapfile -t WARNINGS < <(echo "$2")

is_warning_allowed() {
  local search="$1"
  local element 
  for element in "${WARNINGS[@]}"; do
    if [[ "${element}" == "${search}" ]]; then
      return 0
    fi
  done
  return 1
}

# Directory of the package to check 
chown -R packager "$PKGDIR"
cd "$PKGDIR" || exit 1

# Check PKGBUILD
namcap PKGBUILD | while IFS= read -r line; do 
  if ! is_warning_allowed "$line"; then 
    echo "Warning: '$line' not allowed"
    exit 1
  fi
done

# Check .SRCINFO
if ! sudo -u packager makepkg --printsrcinfo | diff .SRCINFO - ; then
  echo ".SRCINFO is not correct"
  exit 1
fi

# Check packages generated
sudo -u packager makepkg --syncdeps --noconfirm

# Reset path to avoid false warnings in namcap
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin" 

namcap *.pkg.tar.zst | while IFS= read -r line; do
  if ! is_warning_allowed "$line"; then
    echo "Warning: '$line' not allowed"
    exit 1
  fi
done
