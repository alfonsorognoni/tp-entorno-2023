#!/bin/bash

RUTA_DATASETS=$(pwd)compartir/datasets/

menu_descomprimir () {
    # salir si no hay archivos para descomprimir
    if ! ls ${RUTA_DATASETS}imagenes*.tar.gz >/dev/null 2>&1; then
        echo "No hay archivos para descomprimir"
        exit 1
    fi

    # Obtener la lista de archivos existentes en el directorio actual
    archivos_gzip=$(ls ${RUTA_DATASETS}imagenes*.tar.gz)
    archivos_verificacion=$(ls ${RUTA_DATASETS}suma*.txt)
    zip_seleccionado=""
    verificacion_seleccionada=""

    # Contar el número de archivos
    num_zips=$(ls ${RUTA_DATASETS}imagenes*.tar.gz | wc -l)
    num_sumas=$(ls ${RUTA_DATASETS}suma*.txt | wc -l)

    # Variable para mantener el índice del archivo seleccionado
    indice=0

    # Bucle para mostrar la lista y permitir la navegación
    while true; do
        clear  # Limpiar la pantalla
        echo "Archivos:"
        echo "---------"
        if [[ $zip_seleccionado == "" ]]; then
            num_archivos=$num_zips
            archivos=$archivos_gzip
        else
            echo "Archivo gzip seleccionado: $zip_seleccionado"
            num_archivos=$num_sumas
            archivos=$archivos_verificacion
        fi
        
        # Mostrar la lista de archivos con resaltado en el archivo seleccionado
        for ((i=0; i<num_archivos; i++)); do
            if [ $i -eq $indice ]; then
                echo "-> $(echo "$archivos" | sed -n "$((i+1))p")"
            else
                echo "   $(echo "$archivos" | sed -n "$((i+1))p")"
            fi
        done
        if [ $indice -eq $num_archivos ]; then
            echo "-> [Salir]"
        else
            echo "   [Salir]"
        fi

        echo "---------"
        echo "Utilice las teclas arriba y abajo para navegar. Presione Enter para seleccionar el archivo."

        # Leer la entrada del usuario
        read -s -n 1 tecla

        # Manejar la entrada del usuario
        case "$tecla" in
            "A")  # Flecha arriba
                if [ $indice -gt 0 ]; then
                    ((indice--))
                fi
                ;;
            "B")  # Flecha abajo
                if [ $indice -lt $((num_archivos)) ]; then
                    ((indice++))
                fi
                ;;
            "")  # Enter

                # Si seleccionó "Salir", salir del bucle
                if [[ $indice -eq $num_archivos ]]; then
                    break
                fi
                # Obtener el nombre del archivo seleccionado
                if [[ $zip_seleccionado == "" ]]; then
                    zip_seleccionado=$(echo "$archivos" | sed -n "$((indice+1))p")
                    indice=0
                else
                    verificacion_seleccionada=$(echo "$archivos" | sed -n "$((indice+1))p")
                fi

                # Realizar acciones adicionales con el archivo seleccionado
                if [[ $zip_seleccionado != "" && $verificacion_seleccionada != "" ]]; then
                    descomprimir $zip_seleccionado $verificacion_seleccionada
                    break
                fi

                # break  # Salir del bucle
                # ;;
        esac
    done
}

descomprimir() {
    #Valida que la cantidad de argumentos ingresada sea 2
    if [[ $# -ne 2 ]]; then
        echo "ERROR. Número de argumentos incorrecto. Debe ingresar dos argumentos."
        exit 1
    #Valida que los archivos pasados como argumentos existan
    elif [[ ! -f $1 ]]; then
        echo "ERROR. El archivo $1 no existe. Chequeé en la ruta ingresada."
        exit 2
    elif [[ ! -f $2 ]]; then
        echo "ERROR. El archivo $2 no existe. Chequeé en la ruta ingresada."
        exit 3
    #Valida que el primero argumento sea un archivo con extensión '.tar.gz'
    elif ! [[ $1 =~ \.tar\.gz$ ]]; then
        echo "ERROR. El primer argumento debe ser un archivo comprimido con extensión '.tar.gz' ."
        exit 4
    #Valida que el segundo argumento sea un archivo con extensión '.txt'
    elif ! [[ $2 =~ \.txt$ ]]; then
        echo "ERROR. El segundo argumento debe ser un archivo de texto con extensión '.txt' ."
        exit 5
    else
        #Compara la suma de verificación que se encuentra en el archivo del primer argumento con la del segundo argumento
        # echo $(md5sum $1) | cut -d ' ' -f 1
        # cat $2 | cut -d ' ' -f 1
        if [[ $(echo $(md5sum $1) | cut -d ' ' -f 1) == $(cat $2 | cut -d ' ' -f 1) ]]; then
            echo "La suma de verificación proporcionada coincide. Descomprimiendo..."
            mkdir -p ${RUTA_DATASETS}imagenesDescomprimidas #Crea un directorio donde se guardará el archivo descomprimido
            tar -xvf $1 -C ${RUTA_DATASETS}imagenesDescomprimidas #Descomprime el archivo
            echo "Imágenes descomprimidas."
            exit 0
        else
            echo "ERROR. La suma de verificación proporcionada no coincide. La integridad del archivo comprimido puede estar afectada."
            exit 6
        fi
    fi
}

generar_menu() {
    clear
    while true; do
        clear
        echo "Menú - Descomprimir Imágenes"
        echo "------------------------"
        echo "1. Descomprimir imágenes"
        echo "2. Salir"

        read -p "Ingresa una opción: " option

        case $option in
            1)
                menu_descomprimir
                # read -p "Ingrese el archivo de imágenes comprimidas que desea descomprimir." ARCHIVO
			    # read -p "Ingrese el archivo de texto con suma de verificación." SUMA_VERIFICACION
			    # descomprimir $ARCHIVO $SUMA_VERIFICACION
			    ;;
            2) exit ;;
            *) echo "Opción inválida" ;;
        esac
        clear

        read -p "Presiona Enter para continuar..."
    done
}

generar_menu
