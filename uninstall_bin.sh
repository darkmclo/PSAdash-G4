#!bin/sh

echo "[Privilegios elevados (Root) requeridos]"
if [ "$EUID" -ne 0 ]
then
	echo "Por favor, ejecute este script con privilegios elevados."
	echo "Saliendo..."
	exit
else
	echo "[Ejecutando con los privilegios adecuados]"
fi

echo -e "========= REALIZANDO LA CONFIGURACION =========="

sudo rm /usr/bin/PSAdash

sudo unlink /usr/bin/Proyecto
DIR=$(pwd)

echo -e "El proceso de desinstalación se ha completado. \n"
echo -e "Para usar el comando 'PSAdash' reinstalelo usando el script 'install_bin.sh' \nO ejecutelo desde la terminal usando:  sudo sh PSAdash.sh"
echo -e "\nSaliendo..."
