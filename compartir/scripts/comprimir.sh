#!/bin/bash

#directorio de imagenes procesadas
DIR_PROCESADAS="/compartir/datasets/imagenesProcesadas"

#crear directorio para archivos a comprimir
DIR_COMPRIMIR="/compartir/datasets/archivosComprimir"
mkdir -p $DIR_COMPRIMIR

comprimir() {
    #valida que el directorio de imagenes procesadas exista y no este vacio
    if [[ ! -d $DIR_PROCESADAS ]]; then
        echo "ERROR. El directorio imagenesProcesadas no existe."
        exit 1
    elif [[ ! $(ls $DIR_PROCESADAS) ]]; then
        echo "ERROR. El directorio imagenesProcesadas está vacío."
        exit 2
    else
        #crear archivo con el nombre de las imagenes descomprimidas
        ls $DIR_PROCESADAS > $DIR_COMPRIMIR/nombres.txt

        #crear archivo con la lista de nombres de imagenes validas (inician con mayuscula, seguidas de minuscula y terminan con .jpg)
        ls $DIR_PROCESADAS | grep -E '^[A-Z][a-z]+\.jpg$' > $DIR_COMPRIMIR/nombresValidos.txt

        #crear un archivo con la lista de nombres validos que terminan en a.jpg
        ls $DIR_PROCESADAS | grep -E '^[A-Z][a-z]+a\.jpg$' > $DIR_COMPRIMIR/nombresValidosA.txt

        # copiar las imagenes procesadas a un directorio para comprimir
        cp $DIR_PROCESADAS/*.jpg $DIR_COMPRIMIR

        #generar un archivo comprimido tar.gz con todos los archivos anteriores y todas las imagenes procesadas
        tar -czvf compartir/archivo_final.tar.gz -C $DIR_COMPRIMIR .

        #borrar todos los archivos creados y las imagenes copiadas
        rm $DIR_COMPRIMIR/*.txt $DIR_COMPRIMIR/*.jpg
        #borrar todo el contenido del directorio de imagenes procesadas
        rm $DIR_PROCESADAS/*.jpg
    fi
}

comprimir_menu() {
    echo "Seleccione una opción:"
    echo "1. Comprimir imágenes procesadas."
    echo "2. Volver al menú principal."
    read -p "Opción: " OPCION
    case $OPCION in
        1) comprimir ;;
        2) exit 0 ;;
        *) echo "Opción inválida" ;;
    esac
}

comprimir_menu
