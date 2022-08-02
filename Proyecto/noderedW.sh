#!/bin/bash
{
	sudo rpm -qa | grep nodejs
	status=$?

	echo -e "XXX\n0\nIniciando proceso de instalacion... \nXXX"
	sleep 2

	echo -e "XXX\n0\Verificando instalacion de Nodejs... \nXXX"
	sleep 1

	if [ $status -eq 0 ]; then
		echo -e "XXX\n10\nNodejs se encuentra instalado. \nXXX"
		sleep 1
	else
		echo -e "XXX\n10\nNodejs no se encuentra instalado. \nXXX"
		sleep 1
		echo -e "XXX\n20\n======== INSTALANDO NODEJS [LTS] ======== \nXXX"
		sleep 2
		sudo curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
		sudo yum install nodejs -y
	fi

	echo -e "XXX\n50\nVerificando instalacion de Node-RED... \nXXX"
	sleep 1

	package="node-red"
	if [ `npm list -g | grep -c $package` -eq 0 ]; then
		echo -e "XXX\n70\nNode-RED no está instalado. \nXXX"
		sleep 1
		echo -e "XXX\n70\nSe procederá a realizar el proceso de instalación. \nXXX"
		sleep 1
		echo "XXX\n70\n=========== INSTALANDO NODE-RED ===========  \nXXX"
		sleep 1
		sudo npm install -g --unsafe-perm node-red -y
		echo "XXX\n90\n=========== INSTALANDO NODE-RED ===========  \nXXX"
		sleep 1
	else
		echo -e "XXX\n70\nNode-RED se encuentra instalado. \nXXX"
		sleep 1
		echo -e "XXX\n70\n Finalizando... \nXXX"
		sleep 1
	fi

		echo -e "XXX\n100\nProceso finalizado \nXXX"
		sleep 2
		
	
} |whiptail --title "Instalacion de NODE-RED" --gauge "Por favor espere..." 6 60 0