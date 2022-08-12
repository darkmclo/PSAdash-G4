#!/bin/bash
{
        sudo rpm -qa | grep postgresql
        status=$?

        echo -e "XXX\n0\nIniciando proceso de desinstalacion... \nXXX"
        sleep 2

        if [ $status -eq 0 ]; then
                echo -e "XXX\n10\nDesinstalando PostgreSQl. \nXXX"
                sleep 1
                sudo yum --purge remove postgresql
                sudo yum purge postgresql*
                sudo yum --purge remove postgresql postgresql-doc postgresql-common

                echo -e "XXX\n100\nEliminando archivos dependientes\nXXX"
                sleep 2
                sudo rm -rf /var/lib/postgresql/
                sudo rm -rf /var/log/postgresql/
                sudo rm -rf /etc/postgresql/
        else
                echo -e "XXX\n10\nPostgresql no se encuentra instalado. \nXXX"
                sleep 1
        fi

        echo -e "XXX\n100\nProceso finalizado \nXXX"
        sleep 2


} |whiptail --title "Desinstalacion de Postgresql" --gauge "Por favor espere..." 6 60 0


