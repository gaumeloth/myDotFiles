#!/bin/bash -e

# Funzione per gestire gli errori
handle_error() {
  echo "Errore durante l'esecuzione dello script." >&2
  exit 1
}

# Imposta la gestione degli errori utilizzando trap
trap 'handle_error' ERR

# Funzione per eseguire il rename dei file esistenti
rename_existing_file() {
  local file_path=$1
  local backup_suffix="_BKP"
  local backup_file="${file_path}${backup_suffix}"

  # Verifica se il file esiste
  if [[ -e "${file_path}" ]]; then
    echo "Il file ${file_path} esiste già. Rinomino in ${backup_file}"
    mv "${file_path}" "${backup_file}"
  fi
}

# Funzione per eseguire la copia ricorsiva delle directory con il controllo sull'esistenza
copy_directory_with_backup() {
  local source_dir=$1
  local target_dir=$2

  # Utilizzo della funzione rename_existing_file per rinominare la directory di destinazione se esiste già
  rename_existing_file "${target_dir}"

  # Copia ricorsiva della directory nella directory di destinazione
  cp -vr "${source_dir}" "${target_dir}"
}

# Funzione per eseguire la copia di un file con backup
copy_file_with_backup() {
  local source_file=$1
  local target_file=$2
  local use_sudo=$3

  # Utilizzo della funzione rename_existing_file per rinominare il file di destinazione se esiste già
  rename_existing_file "${target_file}"

  # Copia del file nella posizione di destinazione
  if [[ "${use_sudo}" == "--sudo" ]]; then
    sudo cp -v "${source_file}" "${target_file}"
  else
    cp -v "${source_file}" "${target_file}"
  fi
}

# Aggiornamento del sistema
echo "Aggiornamento del sistema"
sudo pacman -Suy
if [[ $? -ne 0 ]]; then
  echo "Errore durante l'aggiornamento del sistema." >&2
  exit 1
fi

# Installazione dei pacchetti
echo "Installazione pacchetti"
sudo pacman -Sy man-db cairo-dock ttf-firacode-nerd rofi neofetch feh variety xscreensaver picom speedcrunch bpytop sddm bat bat-extras git-delta ranger fish starship code discord nemo ueberzug polkit-gnome firefox-i18n-it firefox transmission-qt misfortune flameshot qutebrowser font-manager libreoffice-still libreoffice-still-it pavucontrol-qt ttf-junicode adobe-source-han-sans-otc-fonts noto-fonts-cjk ttf-hannom ttf-khmer ttf-tibetan-machine noto-fonts-emoji otf-latinmodern-math ttf-scheherazade-new adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts adobe-source-han-sans-hk-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts gentium-plus-font ttf-indic-otf
if [[ $? -ne 0 ]]; then
  echo "Errore durante l'installazione dei pacchetti." >&2
  exit 1
fi

# Abilita sddm
echo "Abilita sddm"
sudo systemctl enable sddm.service -f
if [[ $? -ne 0 ]]; then
  echo "Errore durante l'abilitazione di sddm." >&2
  exit 1
fi

# Copia dei file di configurazione nelle rispettive cartelle
echo "Copia file configurazione"
copy_directory_with_backup "alacritty" "~/.config"
copy_directory_with_backup "fish" "~/.config"
copy_directory_with_backup "qutebrowser" "~/.config"
copy_directory_with_backup "qtile" "~/.config"
copy_directory_with_backup "ranger" "~/.config"
copy_directory_with_backup "rofi" "~/.config"
copy_directory_with_backup "variety" "~/.config"
copy_file_with_backup ".gitconfig" "~" "false"
copy_file_with_backup "sddm.conf" "/etc/sddm.conf" "--sudo"
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
paru -S stacer-bin opensiddur-hebrew-fonts persian-fonts ttf-lao chili-sddm-theme
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
