#!/bin/bash
#Validamos que el usuario tenga privilegios de root.
if [ "$EUID" -ne 0 ]
then
	whiptail --title "PSA" --msgbox "Por favor, ejecute este script con privilegios elevados." 8 78
        exit
fi

#Verificando la instalación de postgresql
psql --version

exitstatus=$?
#Si esta instalado, iniciamos el servicio
if [ $exitstatus = 0 ]; then
	if [[ ! "$(systemctl is-active postgresql-11)" == "active" ]]; then
		echo "iniciando postgresql-11"
		systemctl start postgresql-11
	fi
	
	whiptail --title "PSA" --msgbox "Postgresql instalado, se ha iniciado el servicio." 8 78
		
else
#Si no está instalado procedemos a realizar el proceso de instalación.
	whiptail --title "PSA" --msgbox "Postgresql no se encuentra instalado, se procederá a realizar la instalación." 8 78
	bash postgresqlW.sh

	#Validamos si la instalación se realizó correctamente.
	exitstatus=$?	
	if [ $exitstatus = 0 ]; then
		whiptail --title "PSA" --msgbox "Se ha instalado Postgresql y se ha iniciado el servicio :P." 8 78
	else
		whiptail --title "PSA" --msgbox "Ha ocurrido un problema en la instalación de Postgresql." 8 78
	fi
fi

echo "(Exit status was $exitstatus)"

#Verificando si Grafana ya se encuentra instalado
grafana=$(rpm -q grafana)

#Si no está instalado procedemos a realizar el proceso de instalación.
if [[ $grafana == "package grafana is not installed" || $grafana == "el paquete grafana no está instalado" ]]; then

	whiptail --title "PSA" --msgbox "Grafana no se encuentra instalado, se procederá a realizar la instalación." 8 78
	bash grafana.sh

	#Validamos si la instalación se realizó correctamente.
	exitstatus=$?	
	if [ $exitstatus = 0 ]; then
		whiptail --title "PSA" --msgbox "Se ha instalado Grafana y se ha iniciado el servicio :P." 8 78
	else
		whiptail --title "PSA" --msgbox "Ha ocurrido un problema en la instalación de Grafana." 8 78
	fi

else 
#Si ya está instalado procedemos a iniciar el servicio.
	if [[ ! "$(systemctl is-active grafana-server)" == "active" ]]; then
		$(sudo systemctl start grafana-server)
	fi
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		whiptail --title "PSA" --msgbox "Grafana instalado, se ha iniciado el servicio." 8 78
	fi
fi

#Verificando si nodejs está instalado
node -v

exitstatus=$?
#Si ya está instalado procedemos a iniciar el servicio.
if [ $exitstatus = 0 ]; then
	node-red &>/dev/null &
	whiptail --title "PSA" --msgbox "Node-red instalado, se ha iniciado el servicio." 8 78
			
else
#Si no está instalado procedemos a realizar el proceso de instalación.

	whiptail --title "PSA" --msgbox "Node-red no se encuentra instalado, se procederá a realizar la instalación." 8 78
	bash noderedW.sh

	#Validamos si la instalación se realizó correctamente.
	exitstatus=$?	
	if [ $exitstatus = 0 ]; then
		whiptail --title "PSA" --msgbox "Se ha instalado Node-red y se ha iniciado el servicio :P." 8 78
	else
		whiptail --title "PSA" --msgbox "Ha ocurrido un problema en la instalación de Node-red." 8 78
	fi
fi

echo "(Exit status was $exitstatus)"

