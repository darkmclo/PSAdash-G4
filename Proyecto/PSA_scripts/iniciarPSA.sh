#!/bin/bash

if [ "$EUID" -ne 0 ]
then
	whiptail --title "PSA" --msgbox "Por favor, ejecute este script con privilegios elevados." 8 78
        exit
fi

#Verificando la instalación de postgresql
psql=$(psql --version)

exitstatus=$?
#Si esta instalado, iniciamos el servicio
if [ $exitstatus = 0 ]; then
	if [[ ! "$(systemctl is-active postgresql-11)" == "active" ]]; then
		echo "iniciando postgresql-11"
		systemctl start postgresql-11
	fi
	
	whiptail --title "PSA" --msgbox "Postgresql instalado, se ha iniciado el servicio." 8 78
		
else
	whiptail --title "PSA" --msgbox "Postgresql no se encuentra instalado, se procederá a realizar la instalación." 8 78
	bash postgresqlW.sh
fi

echo "(Exit status was $exitstatus)"

#Verificando la instalación de Grafana
grafana=$(rpm -q grafana)

if [[ $grafana == "package grafana is not installed" || $grafana == "el paquete grafana no está instalado" ]]; then
	echo "Grafana  NO instalado!"
	whiptail --title "PSA" --msgbox "Grafana no se encuentra instalado, se procederá a realizar la instalación." 8 78
	bash grafana.sh

else 
	echo "Grafana Instalado"
	
	if [[ ! "$(systemctl is-active grafana-server)" == "active" ]]; then
		$(sudo systemctl start grafana-server)
	fi
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		whiptail --title "PSA" --msgbox "Grafana instalado, se ha iniciado el servicio." 8 78
	fi
fi

#Verificando la instalación de nodejs
nodejs=$(node -v)
echo $nodejs

exitstatus=$?
if [ $exitstatus = 0 ]; then
	node-red
	whiptail --title "PSA" --msgbox "Node-red instalado, se ha iniciado el servicio." 8 78
			
else
	whiptail --title "PSA" --msgbox "Node-red no se encuentra instalado, se procederá a realizar la instalación." 8 78
	bash noderedW.sh
fi

echo "(Exit status was $exitstatus)"

