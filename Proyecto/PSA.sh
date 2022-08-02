#!/bin/bash
cd /usr/bin/Proyecto

if [ "$EUID" -ne 0 ]
then
	whiptail --title "PSA" --msgbox "Por favor, ejecute este script con privilegios elevados." 8 78
        exit
fi

while [ 1 ]
do
CHOICE=$(
whiptail --title "Seleccione una opción" --menu "Choose an option" 16 80 9 \
       "1" "Lanzar servidor PSA" \
       "2" "Configurar servidor PSA" \
	"3" "Configurar entorno de trabajo PSA" \
       "4" "Salir" 3>&1 1>&2 2>&3
)

case $CHOICE in
1) 
	sudo bash PSA_scripts/iniciarPSA.sh
;;

2) 
	sudo bash PSA_scripts/configPSA.sh
;;

3) 
	sudo bash PSA_scripts/flow.sh
;;

4) exit
;;

esac
done
exit
