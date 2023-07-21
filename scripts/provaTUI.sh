#!/bin/bash

# Funzione per visualizzare l'interfaccia utente TUI con whiptail
show_tui() {
  local packages=$(whiptail --title "Selezione dei pacchetti" --checklist \
    "Seleziona i pacchetti da installare:" 20 80 13 \
    "featherpad" "FeatherPad" ON \
    "neovim" "Neovim" ON \
    "code" "Visual Studio Code" OFF \
    "discord" "Discord" OFF \
    "qutebrowser" "Qutebrowser" OFF \
    "libreoffice-still" "LibreOffice (Still)" OFF \
    "libreoffice-still-it" "LibreOffice (Still) Italiano" OFF \
    "firefox-i18n-it" "Firefox (Italiano)" OFF \
    "firefox" "Firefox" OFF \
    3>&1 1>&2 2>&3)

  if [[ $? -eq 0 ]]; then
    selected_packages=($packages)
    sudo pacman -Sy "${selected_packages[@]}"
    if [[ $? -ne 0 ]]; then
      whiptail --title "Errore" --msgbox "Errore durante l'installazione dei pacchetti." 10 50
      exit 1
    fi
    whiptail --title "Completato" --msgbox "Installazione completata con successo!" 10 50
  else
    whiptail --title "Annullato" --msgbox "Installazione annullata." 10 50
    exit 1
  fi
}

# Installazione dei pacchetti di base per il desktop environment
baseDE=(
  "man-db"
  "cairo-dock"
  "cairo-dock-plug-ins"
  "reflector"
  "ttf-firacode-nerd"
  "rofi"
  "neofetch"
  "feh"
  "variety"
  "xscreensaver"
  "picom"
  "speedcrunch"
  "bpytop"
  "sddm"
  "bat"
  "bat-extras"
  "git-delta"
  "ranger"
  "fish"
  "starship"
  "nemo"
  "ueberzug"
  "polkit-gnome"
  "transmission-qt"
  "misfortune"
  "flameshot"
  "font-manager"
  "pavucontrol-qt"
  "ttf-junicode"
  "adobe-source-han-sans-otc-fonts"
  "noto-fonts-cjk"
  "ttf-hannom"
  "ttf-khmer"
  "ttf-tibetan-machine"
  "noto-fonts-emoji"
  "otf-latinmodern-math"
  "ttf-scheherazade-new"
  "adobe-source-han-sans-cn-fonts"
  "adobe-source-han-sans-tw-fonts"
  "adobe-source-han-sans-hk-fonts"
  "adobe-source-han-sans-jp-fonts"
  "adobe-source-han-sans-kr-fonts"
  "gentium-plus-font"
  "ttf-indic-otf"
)

# Visualizza l'interfaccia utente TUI per la selezione dei pacchetti
show_tui
