FROM archlinux:base-devel

# To check binary packages and source PKGBUILD
RUN \
  pacman --noconfirm --noprogressbar -Sy && \
  pacman --noconfirm --noprogressbar -S namcap

# makepkg does not run as root
RUN \
  useradd packager && \
  echo "packager ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/01-packager_user && \
  echo "Defaults lecture = never" > /etc/sudoers.d/privacy

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
