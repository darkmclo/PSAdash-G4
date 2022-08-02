#!/bin/bash
echo "[Privilegios elevados (Root) requeridos]"
if [ "$EUID" -ne 0 ]
then
	whiptail --title "PSA Dash" --msgbox "Por favor, ejecute este script con privilegios elevados." 8 78
	whiptail --title "PSA Dash" --msgbox "Saliendo." 8 78
        exit
else
        echo "[Ejecutando con los privilegios adecuados]"


{
        sudo rpm -qa | grep postgresql11-server
        status=$?

        echo -e "XXX\n0\nIniciando proceso de instalacion... \nXXX"
        sleep 2

        echo -e "XXX\n0\Verificando instalacion de Nodejs... \nXXX"
        sleep 1

        if [ $status -eq 0 ]; then
                echo -e "XXX\n10\nPostgresql se encuentra instalado. \nXXX"
                sleep 1
        else
                echo -e "XXX\n10\nPostgresql no se encuentra instalado. \nXXX"
                sleep 1
                echo -e "XXX\n20\n======== INSTALANDO Postgresql [LTS] ======== \nXXX"
                sleep 2
               
       		 yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
                yum install postgresql11-server -y
 		/usr/pgsql-11/bin/postgresql-11-setup initdb
		systemctl enable postgresql-11
   	        systemctl start postgresql-11


        fi

        echo -e "XXX\n50\nVerificando instalacion de Postgresql... \nXXX"
               sleep 1

        package="postgresql11-server"
        if [ `npm list -g | grep -c $package` -eq 0 ]; then
                echo -e "XXX\n70\nPostgresql no está instalado. \nXXX"
                sleep 1
                echo -e "XXX\n70\nSe procederá a realizar el proceso de instalación. \nXXX"
                sleep 1
                echo "XXX\n70\n=========== INSTALANDO Postgresql ===========  \nXXX"
                sleep 1
                yum install postgresql11-server -y
		/usr/pgsql-11/bin/postgresql-11-setup initdb
                systemctl enable postgresql-11
   	        systemctl start postgresql-11
                echo "XXX\n90\n=========== INSTALANDO Postgresql ===========  \nXXX"
                sleep 1
        else
                echo -e "XXX\n70\nPostgresql se encuentra instalado. \nXXX"
                sleep 1
                echo -e "XXX\n70\n Finalizando... \nXXX"
                sleep 1
        fi

                echo -e "XXX\n100\nProceso finalizado \nXXX"
                sleep 2


} |whiptail --title "Instalacion de Postgresql" --gauge "Por favor espere..." 6 60 0

fi

