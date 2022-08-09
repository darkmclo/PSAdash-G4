#!/bin/bash
{
        sudo rpm -qa | grep postgresql
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
                echo -e "XXX\n20\n======== Descargando Postgresql [LTS] ======== \nXXX"
                sleep 2
                echo -e "XXX\n25\n======== INSTALANDO Postgresql [LTS] ======== \nXXX"
                sleep 1
		sudo yum -y install postgresql-server postgresql-contrib
       		echo -e "XXX\n25\n======== INSTALANDO Postgresql [LTS] ======== \nXXX"
                sleep 1
		sudo systemctl start postgresql
		sudo systemctl enable postgresql


        fi

        echo -e "XXX\n50\nVerificando instalacion de Postgresql... \nXXX"
               sleep 1

        package="postgresql-server"
        if [ `npm list -g | grep -c $package` -eq 0 ]; then
                echo -e "XXX\n70\nPostgresql no esta instalado. \nXXX"
                sleep 1
                echo -e "XXX\n70\nSe procedera a realizar el proceso de instalaciÃ³n. \nXXX"
                sleep 1
                echo "XXX\n70\n=========== INSTALANDO Postgresql ===========  \nXXX"
                sleep 1
                sudo yum -y install postgresql-server postgresql-contrib
		sudo systemctl start postgresql
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




