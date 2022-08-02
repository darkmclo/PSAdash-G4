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

sudo chmod +x PSAdash.sh

sudo cp PSAdash.sh /usr/bin/PSAdash

sudo ln -s $(pwd)/Proyecto /usr/bin/Proyecto

echo -e "El proceso de instalación se ha completado. \n"
echo -e "Use el comando 'PSAdash' desde la terminal para empezar a usar el menu de acciones."
