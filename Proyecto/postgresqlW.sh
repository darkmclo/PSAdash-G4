#!/bin/bash
{
        sudo rpm -qa | grep postgresql
        status=$?

        echo -e "XXX\n0\nIniciando proceso de instalación... \nXXX"
        sleep 2

        echo -e "XXX\n0\Verificando instalación de Nodejs... \nXXX"
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

        echo -e "XXX\n50\nVerificando instalación de Postgresql... \nXXX"
               sleep 1

        package="postgresql-server"
        if [ `npm list -g | grep -c $package` -eq 0 ]; then
                echo -e "XXX\n70\nPostgresql no esta instalado. \nXXX"
                sleep 1
                echo -e "XXX\n70\nSe procederá a realizar el proceso de instalación. \nXXX"
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



        #Creacion de base dedatos y su tabla
        echo -e "XXX\n80\nCreando base de datos PSAII \nXXX"
        sleep 1
        sudo -iu postgres psql -c 'drop database if exists ProyectoPSA2;'
        sudo -iu postgres psql -c 'create database PSAII;'

        echo -e "XXX\n90\nCreando tabla Clase \nXXX"
        sleep 1
        sudo -iu postgres psql -d psaii -c '
        CREATE TABLE clase
        (server char(100) NULL, 
        uptime integer NULL, 
        ramlibre double precision, 
        ramusada double precision, 
        ramtotal double precision, 
        discolibre double precision, 
        discousado double precision, 
        discototal double precision, 
        cpu double precision, 
        ipwlan text, 
        interfaztx integer, 
        interfazrx integer, 
        grafanastatus integer, 
        fecha timestamp without time zone;'

        echo -e "XXX\n100\nProceso finalizado \nXXX"
        sleep 1






} |whiptail --title "Instalación de Postgresql" --gauge "Por favor espere..." 6 60 0




