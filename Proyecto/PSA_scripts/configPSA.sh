#/bin/sh

#echo "Ejecutando configPSA.sh ..."
#sleep 5

cd /usr/bin/Proyecto/PSA_scripts

if [ "$EUID" -ne 0 ]
then
	whiptail --title "PSA" --msgbox "Por favor, ejecute este script con privilegios elevados." 8 78
        exit
fi

while [ 1 ]
do
OPCION=$(
whiptail --title "Configuracion PSA" --menu "Choose an option" 16 80 9 \
       "1" "Configuración de puertos" \
       "2" "Configuración del entorno de trabajo" \
       "3" "Salir" 3>&2 2>&1 1>&3
)

case $OPCION in
"1") 
	sudo bash puertosPSA.sh
;;


"2") 
	#whiptail --title "Entorno PSA" --msgbox "Aquí debe abrirse el script entornoPSA.sh con su respectiva configuración. O sea, el archivo flow.sh con el formato de carpetas correcto." 20 70
	#sudo bash entornoPSA.sh
	sudo bash flow.sh
;;

"3") exit
;;

esac
done
exit