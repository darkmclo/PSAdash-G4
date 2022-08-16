#!/bin/bash
cd /usr/bin/Proyecto

while [ 1 ]
do
CHOICE=$(
whiptail --title "Seleccione una opción" --menu "Choose an option" 16 80 9 \
       "1" "Desinstalar Node-red" \
       "2" "Desinstalar Grafana" \
       "3" "Desinstalar PostgreSQL" \
       "4" "Regresar" 3>&1 1>&2 2>&3
)

case $CHOICE in
1) 
	bash uninstallnoderedW.sh
;;

2) 
	bash uninstallgrafana.sh
;;

3) 
    bash uninstallpostgresqlW.sh
;;

4) exit
;;

esac
done
exit
