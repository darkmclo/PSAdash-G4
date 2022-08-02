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

sudo chmod +x PSA.sh

sudo cp PSA.sh /usr/bin/PSA

sudo ln -s $(pwd)/PSA_scripts /usr/bin/PSA_scripts

echo -e "El proceso de instalación se ha completado. \n"
echo -e "Use el comando 'PSA' desde la terminal para empezar a usar el menu de acciones."
