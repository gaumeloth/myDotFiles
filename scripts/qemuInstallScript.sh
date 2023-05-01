#!/bin/sh
sudo pacman -Suy
sudo pacman -S archlinux-keyring
sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat
sudo pacman -S ebtables iptables
sudo pacman -S libguestfs
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
sudo usermod -a -G libvirt $(whoami)
sudo systemctl restart libvirtd.service
