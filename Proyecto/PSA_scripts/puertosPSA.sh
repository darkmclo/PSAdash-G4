#/bin/sh

#echo "Ejecutando puertosPSA.sh ..."
#sleep 5

if [ "$EUID" -ne 0 ]
then
	whiptail --title "PSA" --msgbox "Por favor, ejecute este script con privilegios elevados." 8 78
        exit
fi

while [ 1 ]
do
OPCION=$(
whiptail --title "Configuracion de Puertos" --menu "Choose an option" 16 80 9 \
       "1" "Puertos para PostgreSQL" \
       "2" "Puertos para Node-RED" \
       "3" "Puertos para Grafana" \
       "4" "Salir" 3>&2 2>&1 1>&3
)

#sudo yum install mlocate -y
#sudo updatedb
case $OPCION in
"1") 
	#whiptail --title "Puertos para PostgreSQL" --msgbox "Para borrar usuarios escriba los nombres dentro del archivo usuariosb.txt e intentelo de nuevo." 20 70
	VALUE_PSQL=$(whiptail --title "Puertos para PostgreSQL" --inputbox "Escriba el puerto para PostgreSQL" 8 39 "5412" 3>&1 1>&2 2>&3)

	exitstatus=$?
	if [ $exitstatus = 0 ]; then
	    CONFIG_FILE=/var/lib/pgsql/data/postgresql.conf
	    #CONFIG_FILE=/home/chriss/test_file.txt
		if [ -f "$CONFIG_FILE" ]; 
		then
		    if grep -q '^#port =*' "$CONFIG_FILE" ; #sudo grep '^#port =*' /var/lib/pgsql/data/postgresql.conf
		    then
		    	OLD_PORT_STR='#port = '	#Busca la línea de código comentada y la establece como la línea a buscar.
		    	NEW_PORT_STR='port = '	#Establece la línea de código que reemplazará a la anterior. (La línea ya no estará comentada cuando se apliquen los cambios)
		    	whiptail --title "Puertos para PostgreSQL" --msgbox "Se ha descomentado la línea de código con el valor del puerto por defecto, cambiandolo por el valor personalizado actual." 20 70
		    	#whiptail --title "Puertos para PostgreSQL" --msgbox "El archivo contiene: $OLD_PORT_STR" 20 70
	    	    elif grep -q '^port =*' "$CONFIG_FILE" ; #sudo grep '^port =*' /var/lib/pgsql/data/postgresql.conf
	    	    then
	    	    	OLD_PORT_STR='port = '	#Busca la línea de código del puerto (ojo: esta ya no se encontrará comentada si se cumple la condición, es porque esta condición es para cambiar la misma línea solo que sin el "#" al inicio)
	    	    	NEW_PORT_STR=$OLD_PORT_STR	#Al no estar comentada la línea de código entonces se procesa exactamente el mismo valor para que se mantenga descomentada.
	    	    	#whiptail --title "Puertos para PostgreSQL" --msgbox "El archivo contiene: $OLD_PORT_STR" 20 70
		    else
		    	whiptail --title "Puertos para PostgreSQL" --msgbox "No se encontró la línea del puerto (PORT) en el archivo de configuración." 20 70
		    	exit
		    fi
		    
	    	    sudo sed -i 's/'"$OLD_PORT_STR"'[^=&]*/'"$NEW_PORT_STR$VALUE_PSQL"'/g' $CONFIG_FILE

		    whiptail --title "Puertos para PostgreSQL" --msgbox "El puerto establecido para el programa es: $VALUE_PSQL. \nPor favor, reinicie el servicio de PostgreSQL." 20 70
		else
		    whiptail --title "Puertos para PostgreSQL" --msgbox "El archivo de configuración del puerto no existe. Verifique que el programa esté instalado correctamente." 20 70
		fi

	else
	    whiptail --title "Puertos para PostgreSQL" --msgbox "El usuario canceló la operacion." 20 70
	fi

	echo "(Exit status was $exitstatus)"
;;

"2") 
	#whiptail --title "Puertos para Node-RED" --msgbox "Error, no hay opciones de puertos disponibles para Node-RED de momento." 20 70

	VALUE_USER=$(whiptail --title "Puertos para Node-RED" --inputbox "Escriba el nombre del usuario (no ROOT) al que quiere aplicarle esta configuración:" 8 55 3>&1 1>&2 2>&3)
	if [ -d "/home/$VALUE_USER" ] && id "$VALUE_USER" &>/dev/null; then	#Verifica si existe el usuario asignado Y TAMBIÉN su directorio home.
	    echo 'El usuario sí existe.'
	    #whiptail --title "Puertos para Node-RED" --msgbox "El usuario sí existe." 8 70
	    
	else
	    whiptail --title "Puertos para Node-RED" --msgbox "El usuario ingresado NO existe. Ingrese un usuario válido." 20 70
	    exit
	fi


	VALUE_NRED=$(whiptail --title "Puertos para Node-RED" --inputbox "Escriba el puerto para Node-RED" 8 39 "1880" 3>&1 1>&2 2>&3)

	exitstatus=$?
	if [ $exitstatus = 0 ]; then

	    CONFIG_FILE=/home/$VALUE_USER/.node-red/settings.js
		if [ -f "$CONFIG_FILE" ]; 
		then    
		    OLD_PORT_STR='uiPort: process.env.PORT || '
	    	    sudo sed -i 's/'"$OLD_PORT_STR"'[^=&]*/'"$OLD_PORT_STR$VALUE_NRED"',/g' $CONFIG_FILE

		    whiptail --title "Puertos para Node-RED" --msgbox "El puerto establecido para el programa es: $VALUE_NRED. \nPor favor, reinicie el servicio de Node-RED." 20 70
		else
		    whiptail --title "Puertos para Node-RED" --msgbox "El archivo de configuración del puerto no existe. Verifique que el programa esté instalado correctamente." 20 70
		fi

	    #whiptail --title "Puertos para Node-RED" --msgbox "El puerto establecido para el programa es: $VALUE_NRED" 20 70
	else
	    whiptail --title "Puertos para Node-RED" --msgbox "El usuario canceló la operacion." 20 70
	fi

	

;;

"3") 
	#whiptail --title "Puertos para Grafana" --msgbox "Error, no hay opciones disponibles para Grafana." 20 70
	VALUE_GRAFANA=$(whiptail --title "Puertos para Grafana" --inputbox "Escriba el puerto para Grafana" 8 39 "3000" 3>&1 1>&2 2>&3)

	exitstatus=$?
	if [ $exitstatus = 0 ]; then
	    CONFIG_FILE=/etc/grafana/grafana.ini
		if [ -f "$CONFIG_FILE" ]; 
		then
		    if grep -q '^;http_port =*' "$CONFIG_FILE" ; #sudo grep '^#port =*' /var/lib/pgsql/data/postgresql.conf
		    then
		    	OLD_PORT_STR=';http_port = '	#Busca la línea de código comentada y la establece como la línea a buscar.
		    	NEW_PORT_STR='http_port = '	#Establece la línea de código que reemplazará a la anterior. (La línea ya no estará comentada cuando se apliquen los cambios)
		    	whiptail --title "Puertos para Grafana" --msgbox "Se ha descomentado la línea de código con el valor del puerto por defecto, cambiandolo por el valor personalizado actual." 20 70
		    	#whiptail --title "Puertos para PostgreSQL" --msgbox "El archivo contiene: $OLD_PORT_STR" 20 70
	    	    elif grep -q '^http_port =*' "$CONFIG_FILE" ; #sudo grep '^port =*' /var/lib/pgsql/data/postgresql.conf
	    	    then
	    	    	OLD_PORT_STR='http_port = '	#Busca la línea de código del puerto (ojo: esta ya no se encontrará comentada si se cumple la condición, es porque esta condición es para cambiar la misma línea solo que sin el "#" al inicio)
	    	    	NEW_PORT_STR=$OLD_PORT_STR	#Al no estar comentada la línea de código entonces se procesa exactamente el mismo valor para que se mantenga descomentada.
	    	    	#whiptail --title "Puertos para PostgreSQL" --msgbox "El archivo contiene: $OLD_PORT_STR" 20 70
		    else
		    	whiptail --title "Puertos para Grafana" --msgbox "No se encontró la línea del puerto (PORT) en el archivo de configuración. " 20 70
		    	exit
		    fi
		    
	    	    sudo sed -i 's/'"$OLD_PORT_STR"'[^=&]*/'"$NEW_PORT_STR$VALUE_GRAFANA"'/g' $CONFIG_FILE

		    whiptail --title "Puertos para Grafana" --msgbox "El puerto establecido para el programa es: $VALUE_GRAFANA. \nPor favor, reinicie el servicio de Grafana." 20 70
		else
		    whiptail --title "Puertos para Grafana" --msgbox "El archivo de configuración del puerto no existe. Verifique que el programa esté instalado correctamente." 20 70
		fi

	    #whiptail --title "Puertos para Grafana" --msgbox "El puerto establecido para el programa es: $VALUE_GRAFANA" 20 70
	else
	    whiptail --title "Puertos para Grafana" --msgbox "El usuario canceló la operacion." 20 70
	fi
;;

"4") exit
;;



esac
done
exit