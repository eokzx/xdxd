FROM ghcr.io/ublue-os/bazzite:stable

# 1. Instalacja narzędzi programistycznych i systemowych (zgodna z nowym szablonem)
RUN dnf5 install -y \
    distrobox \
    podman \
    zsh \
    git \
    fastfetch && \
    dnf5 clean all

# 2. Turbo Prywatność: Szyfrowany DNS (Quad9) i losowy adres MAC karty Wi-Fi/Ethernet
RUN mkdir -p /etc/NetworkManager/conf.d /etc/systemd/resolved.conf.d && \
    printf "[device]\nwifi.scan-rand-mac-address=yes\n\n[connection]\nwifi.cloned-mac-address=random\nethernet.cloned-mac-address=random\n" > /etc/NetworkManager/conf.d/99-privacy.conf && \
    printf "[Resolve]\nDNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net\nDNSOverTLS=yes\n" > /etc/systemd/resolved.conf.d/99-dns-over-tls.conf
