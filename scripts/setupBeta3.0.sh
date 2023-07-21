#!/bin/bash -e

# Funzione per gestire gli errori
handle_error() {
  echo "Errore durante l'esecuzione dello script." >&2
  exit 1
}

# Imposta la gestione degli errori utilizzando trap
trap 'handle_error' ERR

# Aggiornamento del sistema
echo "Aggiornamento del sistema"
sudo pacman -Suy
if [[ $? -ne 0 ]]; then
  echo "Errore durante l'aggiornamento del sistema." >&2
  exit 1
fi

# Installazione dei pacchetti
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

# Abilita sddm
echo "Abilita sddm"
sudo systemctl enable sddm.service -f
if [[ $? -ne 0 ]]; then
  echo "Errore durante l'abilitazione di sddm." >&2
  exit 1
fi

# Copia dei file di configurazione nelle rispettive cartelle
echo "Copia file configurazione"
cp -vr alacritty ~/.config
cp -vr fish ~/.config
cp -vr qutebrowser ~/.config
cp -vr qtile ~/.config
cp -vr ranger ~/.config
cp -vr rofi ~/.config
cp -vr .gitconfig ~
cp -vr variety ~/.config
sudo cp -v sddm.conf /etc/sddm.conf
if [[ $? -ne 0 ]]; then
  echo "Errore durante la copia dei file di configurazione." >&2
  exit 1
fi

# Setup plugin ranger e font rofi
echo "Setup plugin ranger e font rofi"
cd scripts
./rangerPluginsSetup.sh
if [[ $? -ne 0 ]]; then
  echo "Errore durante il setup dei plugin di ranger." >&2
  exit 1
fi
./rofiFontSetup.sh
if [[ $? -ne 0 ]]; then
  echo "Errore durante il setup del font di rofi." >&2
  exit 1
fi
cd -

# Controllo esistenza cartella ~/github e creazione se necessario
echo "Controllo cartella ~/github"
if [[ ! -d ~/github ]]; then
  echo "Creo '~/github/' per organizzare le repository"
  mkdir -p ~/github
fi

# Scaricamento sfondi per variety da repository GitHub
echo "Scarica sfondi per variety"
git clone https://github.com/whoisYoges/lwalpapers.git ~/github/lwalpapers
if [[ $? -ne 0 ]]; then
  echo "Errore durante il download degli sfondi per variety." >&2
  exit 1
fi

# Scaricamento ed installazione paru AUR helper
echo "Scarica ed installa paru AUR helper"
git clone https://aur.archlinux.org/paru.git ~/github/paru
cd ~/github/paru/
makepkg -si
if [[ $? -ne 0 ]]; then
  echo "Errore durante l'installazione di paru." >&2
  exit 1
fi
cd -

# Installazione ulteriori pacchetti tramite AUR
echo "Installazione pacchetti AUR"
paru -S stacer-bin opensiddur-hebrew-fonts persian-fonts ttf-lao chili-sddm-theme betterlockscreen
if [[ $? -ne 0 ]]; then
  echo "Errore durante l'installazione dei pacchetti AUR." >&2
  exit 1
fi

# Installazione e scelta temi grub2
echo "Installazione e scelta temi grub2"
git clone https://github.com/RomjanHossain/Grub-Themes.git ~/github/Grub-Themes
cd ~/github/Grub-Themes
chmod +x install.sh
sudo bash install.sh
if [[ $? -ne 0 ]]; then
  echo "Errore durante l'installazione dei temi grub2." >&2
  exit 1
fi
cd -

# Gestione delle opzioni dell'utente
echo "Seleziona un'opzione:"
echo "1. Esegui il reboot"
echo "2. Non eseguire il reboot"
read -r choice

case $choice in
  1)
    echo "Eseguendo il reboot..."
    sudo reboot
    ;;
  2)
    echo "Non eseguo il reboot."
    # Inserisci qui il codice che gestisce la situazione senza eseguire il reboot
    ;;
  *)
    echo "Opzione non valida."
    exit 1
    ;;
esac
