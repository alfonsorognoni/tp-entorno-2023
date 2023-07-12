#!/bin/bash

RUTA_DATASETS=$(pwd)compartir/datasets/

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
        if [[ $(echo $(md5sum $1) | cut -d ' ' -f 1) == $(cat $2) ]]; then
            echo "La suma de verificación proporcionada coincide. Descomprimiendo..."
            mkdir -p ${RUTA_DATASETS}imagenesDescomprimidas #Crea un directorio donde se guardará el archivo descomprimido
            tar -xvf ${RUTA_DATASETS}imagenes.tar.gz -C ${RUTA_DATASETS}imagenesDescomprimidas #Descomprime el archivo
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
                read -p "Ingrese el archivo de imágenes comprimidas que desea descomprimir." ARCHIVO
			    read -p "Ingrese el archivo de texto con suma de verificación." SUMA_VERIFICACION
			    descomprimir $ARCHIVO $SUMA_VERIFICACION
			    ;;
            2) exit ;;
            *) echo "Opción inválida" ;;
        esac
        clear

        read -p "Presiona Enter para continuar..."
    done
}

generar_menu