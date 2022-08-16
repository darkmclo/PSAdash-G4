#!/bin/bash
{
        echo -e "XXX\n100\n============= COMENZANDO PROCESO DESINSTALACION =============== \nXXX"
        sleep 2
        sudo rmdir /etc/yum.repos.d/grafana.repo
        echo -e "XXX\n75\n============== DESINSTALANDO GRAFANA (OSS) ============== \nXXX"
        sudo yum remove grafana
        sleep 1
        echo -e "XXX\n100\n============= PROCESO FINALIZADO =============== \nXXX"
        sleep 2
		
	
} |whiptail --title "Desinstalacion de Grafana" --gauge "Por favor espere..." 6 60 0
