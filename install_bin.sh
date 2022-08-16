#!bin/sh

echo "[Privilegios elevados (Root) requeridos]"
if [ "$EUID" -ne 0 ]
then
	whiptail --title "PSA Dash" --msgbox "Por favor, ejecute este script con privilegios elevados." 8 78
	echo "Saliendo..."
	exit
else
	echo "[Ejecutando con los privilegios adecuados]"
fi

echo -e "========= REALIZANDO LA CONFIGURACION =========="

sudo chmod +x PSAdash.sh

sudo cp PSAdash.sh /usr/bin/PSAdash

sudo ln -s $(pwd)/Proyecto /usr/bin/Proyecto

whiptail --title "PSA Dash" --msgbox "El proceso de instalación se ha completado. \nUse el comando 'PSAdash' desde la terminal para empezar a usar el menu de acciones." 10 78
#echo -e "El proceso de instalación se ha completado. \n"
#echo -e "Use el comando 'PSAdash' desde la terminal para empezar a usar el menu de acciones."
