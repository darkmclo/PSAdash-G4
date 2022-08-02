#!/bin/bash
cd /usr/bin/Proyecto

while [ 1 ]
do
CHOICE=$(
whiptail --title "Seleccione una opción" --menu "Choose an option" 16 80 9 \
       "1" "Instalación automática de Node-red, Mysql y Grafana" \
       "2" "Aplicación PSA" \
       "3" "Regresar" 3>&1 1>&2 2>&3
)

case $CHOICE in
1) 
	bash noderedW.sh
	bash grafana.sh
	bash postgresqlW.sh
;;

2) 
	bash PSA.sh
;;

3) exit
;;

esac
done
exit
