#!/bin/bash
cd /home/andrea/Proyecto3P/Proyecto/PSA_scripts

CANT=$(whiptail --inputbox "$msgLogs \n\nIngre el nombre del archivo a cargar" 11 55 --title "Configuración Node" 3>&1 1>&2 2>&3)

curl -X POST http://localhost:1880/flows -H 'content-type: application/json' -d @$(pwd)/$CANT