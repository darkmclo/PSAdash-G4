#!/bin/bash
if [ "$EUID" -ne 0 ]
then
	whiptail --title "PSA" --msgbox "Por favor, ejecute este script con privilegios elevados." 8 78
        exit
fi

node=`ps awx | grep 'node-red' |grep -v grep|wc -l`
if [ $node == 0 ]; then
    whiptail --title "PSA" --msgbox "El servicio de node-RED está inactivo. Por favor actívelo." 8 78
else
    i=0
    opc=1
    for f in $(ls /home/yeltsin/Documentos/NodeFLows/)
    do
        # Asigamos las posiciones del arreglo
        files[i]=$opc
        files[i+1]="$f"    # guardamos el nombre del archivo
        ((i+=2))
        ((opc+=1))
    done

    #Mostramos los elementos del arreglo en whiptail
    result=$(
    whiptail --title "Carpeta de flows" \
        --menu "Seleccione un archivo para cargar" 14 40 6 "${files[@]}" 3>&2 2>&1 1>&3-
    );

    if [[ $? == 1 ]]
    then
        whiptail --title "PSA" --msgbox "Operación cancelada." 8 78
    else
        #Obtenemos el indice del arreglo a partir de de la numeracion y sumamos + 1 para encontrar
        #El nombre del archivo
        for i in "${!files[@]}"; do
        [[ "${files[$i]}" = "${result}" ]] && break
        done

        nombre=${files[$((i + 1))]}

        #cd /home/andrea/Proyecto3P/Proyecto/PSA_scripts
        cd /home/yeltsin/Documentos/NodeFLows
        curl -X POST http://localhost:1880/flows -H 'content-type: application/json' -d @$(pwd)/$nombre
    fi



fi
