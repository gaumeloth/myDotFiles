sudo pacman -Suy
sudo pacman -Sy man-db cairo-dock ttf-firacode-nerd rofi neofetch feh variety xscreensaver picom speedcrunch bpytop sddm bat bat-extras git-delta ranger fish starship code discord nemo ueberzug polkit-gnome firefox-i18n-it firefox transmission-qt misfortune flameshot qutebrowser font-manager libreoffice-still libreoffice-still-it pavucontroll-qt ttf-junicode adobe-source-han-sans-otc-fonts noto-fonts-cjk ttf-hannom ttf-khmer ttf-tibetan-machine noto-fonts-emoji otf-latinmodern-math ttf-scheherazade-new adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts adobe-source-han-sans-hk-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts gentium-plus-font ttf-indic-otf

sudo systemctl enable sddm.service -f

cp - vr alacritty ~/.config
cp - vr fish ~/.config
cp - vr qutebrowser ~/.config
cp - vr qtile ~/.config
cp - vr ranger ~/.config
cp - vr rofi ~/.config
cp - vr .gitconfig ~
sudo cp - vr sddm.conf /etc/sddm.conf
sudo cp - vr variety.conf ~/.config/variety

./scripts/rangerPluginsSetup.sh
./scripts/rofiFontSetup.sh

mkdir -p ~/github

git clone https://github.com/whoisYoges/lwalpapers.git ~/github/lwalpapers

git clone https://github.com/RomjanHossain/Grub-Themes.git ~/github/Grub-Themes

git clone https://aur.archlinux.org/paru.git ~/github/paru
cd ~/github/paru/
makepkg -si
cd -

paru -S stacer-bin opensiddur-hebrew-fonts persian-fonts ttf-lao chili-sddm-theme

cd Grub-Themes
chmod +x install.sh
bash install.sh
