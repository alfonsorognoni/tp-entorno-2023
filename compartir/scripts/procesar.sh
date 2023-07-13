#!/bin/bash

RUTA_DATASETS=$(pwd)compartir/datasets/

procesar() {
    while true; do
        clear
        echo "Buscando imagenes..."
        sleep 1
        # datasets/imagenesDescomprimidas tomo todas las imagenes de la carpeta cuyo nombre inicia con MAYUSCULA
        PATRON=".*/[A-Z][a-z]+\.jpg$"

        if ls ${RUTA_DATASETS}imagenesDescomprimidas/*.jpg | grep -E $PATRON >/dev/null 2>&1; then #Si el comando ls no produce errores
            mkdir -p /compartir/datasets/imagenesProcesadas # Crea el directorio 'imagenesProcesadas' si no existe
            for imagen in $(ls ${RUTA_DATASETS}imagenesDescomprimidas/*.jpg | grep -E $PATRON); do #Recorre todas las imagenes que coincidan con el patron
                echo "Procesando $imagen..."
                nombreImagen=$(basename "$imagen") #Obtiene el nombre de la imagen
                convert "$imagen" -resize 512x512^ -gravity center -extent 512x512 "/compartir/datasets/imagenesProcesadas/$nombreImagen" #Recorta la imagen
                sleep 1
            done
        else
            echo "No se encontraron imagenes para procesar en el directorio imagenesDescomprimidas"
            exit 1
        fi

        read -p "Presiona Enter para continuar..."
        exit 0
    done

}

procesar_menu() {
    clear
    while true; do
        clear
        echo "Menú - Procesar Imágenes"
        echo "------------------------"
        echo "1. Procesar imagenes"
        echo "2. Salir"

        read -p "Ingresa una opción: " option

        case $option in
            1) procesar ;;
            2) exit ;;
            *) echo "Opción inválida" ;;
        esac
        clear

        read -p "Presiona Enter para continuar..."
    done
}

procesar_menu