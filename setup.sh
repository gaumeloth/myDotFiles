#!/bin/bash

#questo è momentaneame solo uno scheletro non ancora funzionante per automatizzare/semplificare il processo di installazione
#e personalizzazione di varie aplicazioni per creare un semplice desktop enviorment secondo i miei gusti e necessità

whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "questo è momentaneame solo uno scheletro non ancora funzionante per automatizzare/semplificare il processo di installazione e personalizzazione di varie aplicazioni per creare un semplice desktop enviorment secondo i miei gusti e necessità" 0 0

if [ -x "$(command -v pacman)" ]; then
	pakagemanager=pacman
elif [ -x "$(command -v apt)" ]; then
	pakagemanager=apt
else
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "questo script non è compatibile con il sistema operativo corrente" 0 0
fi

whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox $pakagemanager" verrà usato da questo scrip per installare eventuali programmi" 0 0

if ! [ -x "$(command -v fish)" ]; then
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "fish non è installato" 0 0
	if (whiptail --title "mydot setup" --backtitle "mydot setup" --fb --yesno "vuoi installare fish?" 0 0); then
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "fish verrà installato e configurato" 0 0
		#inserire installazione 
	else
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "i file di confuigurazione di fish non verranno copiati" 0 0
		#inserire controllo per non copiare i file di cofigurazione associati
	fi
else
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "fish  è installato" 0 0
fi

if ! [ -x "$(command -v qtile)" ]; then
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "qtile non è installato" 0 0
	if (whiptail --title "mydot setup" --backtitle "mydot setup" --fb --yesno "vuoi installare qtile?" 0 0); then
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "qtile verrà installato e configurato" 0 0
		#inserire installazione 
	else
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "i file di confuigurazione di qtile non verranno copiati" 0 0
		#inserire controllo per non copiare i file di cofigurazione associati
	fi
else
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "qtile è installato" 0 0
fi

if ! [ -x "$(command -v qutebrowser)" ]; then
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "qutebrowser non è installato" 0 0
	if (whiptail --title "mydot setup" --backtitle "mydot setup" --fb --yesno "vuoi installare qutebrowser?" 0 0); then
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "qutebrowser verrà installato e configurato" 0 0
		#inserire installazione 
	else
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "i file di confuigurazione di qutebrowser non verranno copiati" 0 0
		#inserire controllo per non copiare i file di cofigurazione associati
	fi
else
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "qutebrowser è installato" 0 0
fi

if ! [ -x "$(command -v ranger)" ]; then
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "ranger non è installato" 0 0
	if (whiptail --title "mydot setup" --backtitle "mydot setup" --fb --yesno "vuoi installare ranger?" 0 0); then
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "ranger verrà installato e configurato" 0 0
		#inserire installazione 
	else
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "i file di confuigurazione di ranger non verranno copiati" 0 0
		#inserire controllo per non copiare i file di cofigurazione associati
	fi
else
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "ranger è installato" 0 0
fi

if ! [ -x "$(command -v rofi)" ]; then
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "rofi non è installato" 0 0
	if (whiptail --title "mydot setup" --backtitle "mydot setup" --fb --yesno "vuoi installare rofi?" 0 0); then
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "rofi verrà installato e configurato" 0 0
		#inserire installazione 
	else
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "i file di confuigurazione di rofi non verranno copiati" 0 0
		#inserire controllo per non copiare i file di cofigurazione associati
	fi
else
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "rofi è installato" 0 0
fi

if ! [ -x "$(command -v alacritty)" ]; then
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "alacritty non è installato" 0 0
	if (whiptail --title "mydot setup" --backtitle "mydot setup" --fb --yesno "vuoi installare alacritty?" 0 0); then
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "alacritty verrà installato e configurato" 0 0
		#inserire installazione 
	else
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "i file di confuigurazione di alacritty non verranno copiati" 0 0
		#inserire controllo per non copiare i file di cofigurazione associati
	fi
else
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "alacritty è installato" 0 0
fi

if ! [ -x "$(command -v flameshot)" ]; then
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "flameshot non è installato" 0 0
	if (whiptail --title "mydot setup" --backtitle "mydot setup" --fb --yesno "vuoi installare flameshot?" 0 0); then
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "flameshot verrà installato e configurato" 0 0
		#inserire installazione 
	else
		whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "i file di confuigurazione di flameshot non verranno copiati" 0 0
		#inserire controllo per non copiare i file di cofigurazione associati
	fi
else
	whiptail --title "mydot setup" --backtitle "mydot setup " --fb --msgbox "flameshot è installato" 0 0
fi
