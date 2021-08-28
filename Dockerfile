FROM archlinux:base-devel
LABEL maintainer="Jeromy Altuna"

# To check binary packages and source PKGBUILD
RUN pacman --noconfirm --noprogressbar -Sy && \
    pacman --noconfirm --noprogressbar -S namcap

# makepkg does not run as root
RUN useradd -G wheel packager && \
    sed -e 's|# %wheel ALL=(ALL) N|%wheel ALL=(ALL) N|g' -i '/etc/sudoers'

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
