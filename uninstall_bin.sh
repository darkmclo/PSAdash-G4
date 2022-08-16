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

SH_FILE=/usr/bin/PSAdash
if [ -f "$SH_FILE" ]; 
then    
    sudo rm /usr/bin/PSAdash
    RESULT1="Comando 'PSAdash' borrado. "
    FLAG_1=1
else
	RESULT1="El comando 'PSAdash' no existe. "
	FLAG_1=0
fi

SH_DIR=/usr/bin/Proyecto
if [ -d "$SH_DIR" ]; 
then
    sudo unlink /usr/bin/Proyecto
    RESULT2="El enlace símbolo (symlink) de Proyecto se ha borrado existosamente. "
    FLAG_2=1
else
	RESULT2="No existe ningún enlace símbolo de la carpeta de Proyecto. "
	FLAG_2=0
fi


#PROCESS_RESULT="$RESULT1$RESULT2"
PROCESS_RESULT="${RESULT1} \n${RESULT2}"

whiptail --title "PSA Dash" --msgbox "${PROCESS_RESULT}" 10 78

DIR=$(pwd)

if [ $FLAG_1 -ne 1 ] && [ $FLAG_2 -ne 1 ];
then
    whiptail --title "PSA Dash" --msgbox "Se ejecutó el proceso de desinstalación pero uno o ninguno de los archivos fueron desinstalados. El script pudo no haberse instalado anteriormente y no se encuentran los ficheros a desinstalar." 10 78
else
    whiptail --title "PSA Dash" --msgbox "El proceso de desinstalación se ha completado. \nPara usar el comando 'PSAdash' reinstalelo usando el script 'install_bin.sh' o ejecutelo desde la terminal usando: \nsudo sh PSAdash.sh" 10 78
fi

#echo -e "El proceso de desinstalación se ha completado. \n"
#echo -e "Para usar el comando 'PSAdash' reinstalelo usando el script 'install_bin.sh' \nO ejecutelo desde la terminal usando:  sudo sh PSAdash.sh"
echo -e "\nSaliendo..."
