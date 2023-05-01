#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x), Discacciati Guido (gaumeloth)
## Github : @adi1090x
#
## Installer Script

## Colors ----------------------------
Color_Off='\033[0m'
BYellow='\033[1;33m'
BBlue='\033[1;34m'
## Directories ----------------------------
DIR=`pwd`
FONT_DIR="$HOME/.local/share/fonts"

# Install Fonts
install_fonts() {
	echo -e ${BBlue}"\n[*] Installing fonts..." ${Color_Off}
	if [[ -d "$FONT_DIR" ]]; then
		cp -rf $DIR/fonts/* "$FONT_DIR"
	else
		mkdir -p "$FONT_DIR"
		cp -rf $DIR/fonts/* "$FONT_DIR"
	fi
	echo -e ${BYellow}"[*] Updating font cache...\n" ${Color_Off}
	fc-cache
}

# Main
main() {
	install_fonts
}

main
