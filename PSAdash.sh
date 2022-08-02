#!/bin/bash
cd /usr/bin/

if [ "$EUID" -ne 0 ]
then
	whiptail --title "PSA Dash" --msgbox "Por favor, ejecute este script con privilegios elevados." 8 78
        exit
fi

while [ 1 ]
do
CHOICE=$(
whiptail --title "Seleccione una opción" --menu "Choose an option" 16 80 9 \
       "1" "Instalar aplicación PSA" \
       "2" "Desinstalar aplicación PSA" \
       "3" "Salir" 3>&1 1>&2 2>&3
)

case $CHOICE in
1) 
	sh Proyecto/instalarPSA.sh
	
;;

2) 
	whiptail --title "PSA" --msgbox "Se va a desinstalar los programas" 8 78

;;

3) exit
;;

esac
done
exit
