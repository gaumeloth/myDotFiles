echo "aggiornamento del sistema"
sudo pacman -Suy
echo "installazione pacchetti"
sudo pacman -Sy man-db cairo-dock ttf-firacode-nerd rofi neofetch feh variety xscreensaver picom speedcrunch bpytop sddm bat bat-extras git-delta ranger fish starship code discord nemo ueberzug polkit-gnome firefox-i18n-it firefox transmission-qt misfortune flameshot qutebrowser font-manager libreoffice-still libreoffice-still-it pavucontrol-qt ttf-junicode adobe-source-han-sans-otc-fonts noto-fonts-cjk ttf-hannom ttf-khmer ttf-tibetan-machine noto-fonts-emoji otf-latinmodern-math ttf-scheherazade-new adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts adobe-source-han-sans-hk-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts gentium-plus-font ttf-indic-otf

echo "abilita sddm"
sudo systemctl enable sddm.service -f

echo "copia file configurazione"
cp -vr alacritty ~/.config
cp -vr fish ~/.config
cp -vr qutebrowser ~/.config
cp -vr qtile ~/.config
cp -vr ranger ~/.config
cp -vr rofi ~/.config
cp -vr .gitconfig ~
sudo cp -vr sddm.conf /etc/sddm.conf
sudo cp -vr variety.conf ~/.config/variety

echo "setup plugin ranger e font rofi"
cd scripts
./rangerPluginsSetup.sh
./rofiFontSetup.sh
cd -

echo "controlla se esiste una cartella ~/github ed eventualmente ne crea una"
if [[ ! -d ~/github ]]; then
	echo "creo '~/github/' per organizzare le repository"
	mkdir -p ~/github
fi

echo "scarica sfondi per variety"
git clone https://github.com/whoisYoges/lwalpapers.git ~/github/lwalpapers

echo "scarica ed installa paru AUR helper"
git clone https://aur.archlinux.org/paru.git ~/github/paru
cd ~/github/paru/
makepkg -si
cd -

echo "installazione di ulteriori pacchetti non disponibili dai repo ufficilai tramite AUR"
paru -S stacer-bin opensiddur-hebrew-fonts persian-fonts ttf-lao chili-sddm-theme

echo "installazione e scleta temi grub2"
git clone https://github.com/RomjanHossain/Grub-Themes.git ~/github/Grub-Themes
cd ~/github/Grub-Themes
chmod +x install.sh
bash install.sh
echo "configurazione comletata (speriamo)"
echo "Seleziona un'opzione:"
echo "1. Esegui il reboot"
echo "2. Non eseguire il reboot"

read choice

if [ "$choice" = "1" ]; then
    echo "Eseguendo il reboot..."
    sudo reboot
elif [ "$choice" = "2" ]; then
    echo "Non eseguo il reboot."
    # Inserisci qui il codice che gestisce la situazione senza eseguire il reboot
else
    echo "Opzione non valida."
fi 
