#!/bin/bash -e

# Funzione per gestire gli errori
handle_error() {
  echo "Errore durante l'esecuzione dello script." >&2
  exit 1
}

# Imposta la gestione degli errori utilizzando trap
trap 'handle_error' ERR

# Funzione per selezionare ed installare programmi aggiuntivi
show_intaller() {
  whiptail --title "Installazione programmi aggiuntivi" --msgbox "Inizio installazione programmi aggiuntivi." 10 50
  # Array con tutti i pacchetti opzionali
  optional_packages=(
    "featherpad" "FeatherPad" OFF
    "neovim" "Neovim" OFF
    "code" "Visual Studio Code" OFF
    "discord" "Discord" OFF
    "qutebrowser" "Qutebrowser" OFF
    "libreoffice-still" "LibreOffice (Still)" OFF
    "libreoffice-still-it" "LibreOffice (Still) Italiano" OFF
    "firefox-i18n-it" "Firefox (Italiano)" OFF
    "firefox" "Firefox" OFF
  )

  # Mostra la checklist per la selezione dei pacchetti opzionali
  selected_optional_packages=$(whiptail --title "Selezione pacchetti opzionali" --checklist \
    "Seleziona i pacchetti opzionali da installare:" 20 80 13 "${optional_packages[@]}" 3>&1 1>&2 2>&3)

  if [[ $? -ne 0 ]]; then
    # L'utente ha premuto Cancel
    whiptail --title "Annullato" --msgbox "Installazione annullata." 10 50
    exit 1
  fi

  # Converti la lista selezionata in un array
  selected_optional_packages_array=($selected_optional_packages)

  # Esegui l'installazione dei pacchetti opzionali selezionati
  sudo pacman -Sy "${selected_optional_packages_array[@]}"
  if [[ $? -ne 0 ]]; then
    whiptail --title "Errore" --msgbox "Errore durante l'installazione dei pacchetti opzionali." 10 50
    exit 1
  fi

  # Comunica all'utente l'esito dell'installazione
  whiptail --title "Completato" --msgbox "Installazione pacchetti opzionali completata con successo!" 10 50
}

# Directory di destinazione
github_dir="$HOME/github"

# Aggiornamento del sistema
echo "Aggiornamento del sistema"
sudo pacman -Suy
if [[ $? -ne 0 ]]; then
  echo "Errore durante l'aggiornamento del sistema." >&2
  exit 1
fi

# Installazione dei pacchetti
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
whiptail --title "Installazione desktop environment" --msgbox "Installazione iniziata." 10 50
sudo pacman -Sy "${baseDE[@]}"
if [[ $? -ne 0 ]]; then
  whiptail --title "Errore" --msgbox "Errore durante l'installazione dei pacchetti base." 10 50
  exit 1
elif
  whiptail --title "Completato" --msgbox "Installazione dei pacchetti base completata!" 10 50
fi

# Visualizza l'interfaccia utente TUI per la selezione dei pacchetti
show_installer

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
if [[ ! -d "$github_dir" ]]; then
  echo "Creo '~/github/' per organizzare le repository"
  mkdir -p "$github_dir"
fi

# Scaricamento sfondi per variety da repository GitHub
echo "Scarica sfondi per variety"
if [[ ! -d "$github_dir/lwalpapers" ]]; then
  git clone https://github.com/whoisYoges/lwalpapers.git "$github_dir/lwalpapers"
  if [[ $? -ne 0 ]]; then
    echo "Errore durante il download degli sfondi per variety." >&2
    exit 1
  fi
else
  echo "Cartella '$github_dir/lwalpapers' già esistente. Salto il download."
fi

# Scaricamento ed installazione paru AUR helper
echo "Scarica ed installa paru AUR helper"
if ! command -v paru &> /dev/null; then
  git clone https://aur.archlinux.org/paru.git "$github_dir/paru"
  cd "$github_dir/paru/"
  makepkg -si
  if [[ $? -ne 0 ]]; then
    echo "Errore durante l'installazione di paru." >&2
    exit 1
  fi
else
  echo "Paru è già installato. Salto l'installazione."
fi

# Installazione ulteriori pacchetti tramite AUR
echo "Installazione pacchetti AUR"
paru -S stacer-bin opensiddur-hebrew-fonts persian-fonts ttf-lao chili-sddm-theme betterlockscreen
if [[ $? -ne 0 ]]; then
  echo "Errore durante l'installazione dei pacchetti AUR." >&2
  exit 1
fi

# Installazione e scelta temi GRUB2
echo "Installazione e scelta temi GRUB2"
if [[ ! -d "$github_dir/Grub-Themes" ]]; then
  git clone https://github.com/RomjanHossain/Grub-Themes.git "$github_dir/Grub-Themes"
  cd "$github_dir/Grub-Themes"
  chmod +x install.sh
  sudo bash install.sh
  if [[ $? -ne 0 ]]; then
    echo "Errore durante l'installazione dei temi GRUB2." >&2
    exit 1
  fi
  cd -
else
  echo "Cartella '$github_dir/Grub-Themes' già esistente. Salto il download e l'installazione dei temi."
fi

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
