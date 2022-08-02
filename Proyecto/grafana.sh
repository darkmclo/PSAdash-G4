#!/bin/bash
{
	DIR="/etc/yum.repos.d/"
        FILE_REPO="/etc/yum.repos.d/grafana.repo"

        if [ -d "$DIR" ]; then
                #Si existe
                echo -e "XXX\n0\nEl directorio $DIR ya existe. Sobreescribiendo... \nXXX"
                sleep 2

                if [ -f "$FILE_REPO" ]; then
                        #Si existe
                        echo -e "XXX\n25\nEl archivo $FILE_REPO ya existe. \nXXX"
                else
                        sudo touch /etc/yum.repos.d/grafana.repo
                        echo -e "XXX\n25\nSe ha creado el fichero $FILE_REPO \nXXX"
                fi

        else
                #No existe
                sudo mkdir /etc/yum.repos.d
                echo -e "XXX\n0\nSe ha creado el directorio $DIR \nXXX"
                sudo touch /etc/yum.repos.d/grafana.repo
                echo -e "XXX\n25\nSe ha creado el fichero $FILE_REPO \nXXX"
        fi

        sudo cat grafana_preconfig > /etc/yum.repos.d/grafana.repo

        sudo yum update -y

        echo -e "XXX\n75\n============== INSTALANDO GRAFANA (OSS) ============== \nXXX"
        sudo yum install grafana -y
        sleep 1
        echo -e "XXX\n100\n============= PROCESO FINALIZADO =============== \nXXX"
        sleep 2
		
	
} |whiptail --title "Instalacion de Grafana" --gauge "Por favor espere..." 6 60 0
