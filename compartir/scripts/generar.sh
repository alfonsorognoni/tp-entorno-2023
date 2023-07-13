#!/bin/bash

RUTA_DATASETS=$(pwd)compartir/datasets/

generar() {
    while true; do
        read -p "Ingresa el número de imágenes a generar: (-1 para volver)" NUM
        if [[ $NUM == "-1" ]]; then
            break
        elif [[ $NUM =~ ^[0-9]+$ && $NUM -gt 0 ]]; then #Valida que sea un número entero positivo
            LINK="https://source.unsplash.com/random/900%C3%97700/?person"
            mkdir -p ${RUTA_DATASETS}imagenes # Crea el directorio 'imagenes' si no existe
            
            for ((i=1; i<=$NUM; i++)); do
                NOMBRE=$(sed -n "$RANDOM p" ${RUTA_DATASETS}nombres.csv) #Elige un nombre aleatorio de una lista de nombres
	            NOMBRE=$(echo $NOMBRE | cut -d ',' -f 1) #Toma lo que esta antes de la coma (Aaron Damian,85 -> Aaron Damian)
                NOMBRE=$(echo $NOMBRE | cut -d ' ' -f 1) #Corta los espacios dentro del nombre (Aaron Damian -> Aaron)

                wget "$LINK" -O "${RUTA_DATASETS}imagenes/$NOMBRE.jpg" #Genera una imagen y la guarda en la carpeta 'imagenes'
                echo "Descargando la imagen numero $i..."
                sleep 1 #Espera entre descarga y descarga para no saturar el servicio
            done
            echo "Imágenes generadas. Comprimiendo..."
            FECHA=$(date +"%Y%m%d%H%M%S")
            tar -czf ${RUTA_DATASETS}imagenes_${FECHA}.tar.gz -C ${RUTA_DATASETS}imagenes . #Comprime las imagenes generadas
            md5sum ${RUTA_DATASETS}imagenes_${FECHA}.tar.gz > ${RUTA_DATASETS}suma_verificacion_${FECHA}.txt #Genera el archivo de suma de verificación
            echo "Imágenes comprimidas. Suma de verificación generada."
        else
            echo "Ingresa un número válido"
        fi
        read -p "Presiona Enter para continuar..."
    done

}

generar_menu() {
    clear
    while true; do
        clear
        echo "Menú - Generar Imágenes"
        echo "------------------------"
        echo "1. Generar imagenes"
        echo "2. Salir"

        read -p "Ingresa una opción: " option

        case $option in
            1) generar ;;
            2) exit ;;
            *) echo "Opción inválida" ;;
        esac
        clear

        read -p "Presiona Enter para continuar..."
    done
}

generar_menu