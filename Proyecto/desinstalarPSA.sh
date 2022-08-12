#bash desinstalar_noderedW.sh
#bash desinstalar_grafana.sh
#bash desinstalar_postgresqlW.sh

#!/bin/bash
cd /usr/bin/Proyecto

while [ 1 ]
do
CHOICE=$(
whiptail --title "Seleccione una opción" --menu "Choose an option" 16 80 9 \
       "1" "Desinstalación automática de Node-red, Grafana y PostgreSQL" \
       "2" "Desintalación manual" \
       "3" "Regresar" 3>&1 1>&2 2>&3
)

case $CHOICE in
1) 
	bash uninstallnoderedW.sh
	bash uninstallgrafana.sh
	bash uninstallpostgresqlW.sh
;;

2) 
	bash desinstalacionManual.sh
;;

3) exit
;;

esac
done
exit
