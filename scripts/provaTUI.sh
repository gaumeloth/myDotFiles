#!/bin/bash

# Funzione per visualizzare l'interfaccia utente TUI con whiptail
show_tui() {
  local selected_packages=()
  local options=("featherpad" "FeatherPad" "off"
                 "neovim" "Neovim" "off"
                 "code" "Visual Studio Code" "off"
                 "discord" "Discord" "off"
                 "qutebrowser" "Qutebrowser" "off"
                 "libreoffice-still" "LibreOffice (Still)" "off"
                 "libreoffice-still-it" "LibreOffice (Still) Italiano" "off"
                 "firefox-i18n-it" "Firefox (Italiano)" "off"
                 "firefox" "Firefox" "off")

  while true; do
    selected_package=$(whiptail --title "Selezione dei pacchetti" --menu \
      "Seleziona i pacchetti da installare:" 20 80 13 "${options[@]}" 3>&1 1>&2 2>&3)
    
    if [[ $? -eq 0 ]]; then
      for i in "${!options[@]}"; do
        if [[ "${options[i]}" == "$selected_package" ]]; then
          options[i+2]="on"
          selected_packages+=("${options[i]}")
        fi
      done
    else
      break
    fi
  done

  if [[ ${#selected_packages[@]} -eq 0 ]]; then
    whiptail --title "Annullato" --msgbox "Installazione annullata." 10 50
    exit 1
  fi

  sudo pacman -Sy "${selected_packages[@]}"
  if [[ $? -ne 0 ]]; then
    whiptail --title "Errore" --msgbox "Errore durante l'installazione dei pacchetti." 10 50
    exit 1
  fi

  whiptail --title "Completato" --msgbox "Installazione completata con successo!" 10 50
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
whiptail --title "Installazione desktop enviorment" --msgbox "Installazione iniziata." 10 50
sudo pacman -Sy "${baseDE[@]}"
if [[ $? -ne 0 ]]; then
  whiptail --title "Errore" --msgbox "Errore durante l'installazione dei pacchetti base." 10 50
  exit 1
fi

# Visualizza l'interfaccia utente TUI per la selezione dei pacchetti
show_tui
