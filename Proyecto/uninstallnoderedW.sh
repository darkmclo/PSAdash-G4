#!/bin/bash
{
	sudo rpm -qa | grep nodejs
	status=$?

	echo -e "XXX\n0\nIniciando proceso de desintalacion... \nXXX"
	sleep 2


	package="node-red"
	if [ `npm list -g | grep -c $package` -eq 0 ]; then
		echo -e "XXX\n70\nNode-RED no está instalado. \nXXX"
		sleep 1
		
	else
		echo "XXX\n70\n=========== DESINSTALANDO NODE-RED ===========  \nXXX"
		sleep 1
		sudo npm -g remove node-red -y
        sudo npm -g remove node-red-admin -y
        rm -R ~/.node-red -y
		echo -e "XXX\n70\n Finalizando... \nXXX"
		sleep 1
	fi

		echo -e "XXX\n100\nVERIFICANDO NODE JS \nXXX"
		sleep 2

	if [ $status -eq 0 ]; then
		echo -e "XXX\n20\n======== DESINSTALANDO NODEJS [LTS] ======== \nXXX"
		sleep 2
		sudo yum remove nodejs -y

	else
		echo -e "XXX\n10\nNodejs no se encuentra instalado. \nXXX"
		sleep 1
		
	fi	

    echo -e "XXX\n0\nProceso de Finalizado\nXXX"
	sleep 2
	
} |whiptail --title "Desintalacion de NODE-RED" --gauge "Por favor espere..." 6 60 0