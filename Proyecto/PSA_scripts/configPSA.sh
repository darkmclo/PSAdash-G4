#/bin/sh

#echo "Ejecutando configPSA.sh ..."
#sleep 5

while [ 1 ]
do
OPCION=$(
whiptail --title "Configuracion de Puertos" --menu "Choose an option" 16 80 9 \
       "1" "Puertos para PostgreSQL" \
       "2" "Puertos para Node-RED" \
       "3" "Puertos para Grafana" \
       "4" "Salir" 3>&2 2>&1 1>&3
)

case $OPCION in
"1") 
	#whiptail --title "Puertos para PostgreSQL" --msgbox "Para borrar usuarios escriba los nombres dentro del archivo usuariosb.txt e intentelo de nuevo." 20 70
	VALUE_PSQL=$(whiptail --title "Puertos para PostgreSQL" --inputbox "Escriba el puerto para PostgreSQL" 8 39 "5412" 3>&1 1>&2 2>&3)

	exitstatus=$?
	if [ $exitstatus = 0 ]; then
	    #EN ESTA LINEA SE HARA LA OPERACION DE SETEO DEL PUERTO PARA POSTERIORMENTE IMPRIMIR EL MENSAJE INFERIOR.
	    whiptail --title "Puertos para PostgreSQL" --msgbox "El puerto establecido para el programa es: $VALUE_PSQL" 20 70
	else
	    whiptail --title "Puertos para PostgreSQL" --msgbox "El usuario canceló la operacion." 20 70
	fi

	echo "(Exit status was $exitstatus)"
;;

"2") 
	whiptail --title "Puertos para Node-RED" --msgbox "Error, no hay opciones de puertos disponibles para Node-RED de momento." 20 70

;;

"3") 
	#whiptail --title "Puertos para Grafana" --msgbox "Error, no hay opciones disponibles para Grafana." 20 70
	VALUE_GRAFANA=$(whiptail --title "Puertos para Grafana" --inputbox "Escriba el puerto para Grafana" 8 39 "3000" 3>&1 1>&2 2>&3)

	exitstatus=$?
	if [ $exitstatus = 0 ]; then
	    whiptail --title "Puertos para Grafana" --msgbox "El puerto establecido para el programa es: $VALUE_GRAFANA" 20 70
	else
	    whiptail --title "Puertos para Grafana" --msgbox "El usuario canceló la operacion." 20 70
	fi
;;

"4") exit
;;



esac
done
exit