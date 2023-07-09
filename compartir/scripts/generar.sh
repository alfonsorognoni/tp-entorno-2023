#!/bin/bash

generar() {
    while true; do
        read -p "Ingresa el número de imágenes a generar: (-1 para volver)" NUM
        if [[ $NUM == "-1" ]]; then
            break
        elif [[ $NUM =~ ^[0-9]+$ && $NUM -gt 0]]; then #Valida que sea un número entero positivo
            LINK="https://source.unsplash.com/random/900%C3%97700/?person"
            for ((i=1; i<=$NUM; i++)); do
                NOMBRE=$(sed -n "$RANDOM p" datasets/nombres) #Elige un nombre aleatorio de una lista de nombres
	            NOMBRE=$(echo $NOMBRE | cut -d ',' -f 1) #Toma lo que esta antes de la coma (Aaron Damian,85 -> Aaron Damian)
	            NOMBRE=$(echo $NOMBRE | tr -d ' ') #Quita los espacios dentro del nombre (Aaron Damian -> AaronDamian)

                wget "$LINK" -O "datasets/imagenes/$NOMBRE.jpg" #Genera una imagen y la guarda en la carpeta 'imagenes'
                echo "Descargando la imagen numero $i..."
                sleep 1 #Espera entre descarga y descarga para no saturar el servicio
            done
            echo "Imágenes generadas. Comprimiendo..."
            tar -czf datasets/imagenes.tar.gz -C datasets/imagenes #Comprime las imagenes generadas
            md5sum datasets/imagenes.tar.gz > suma_verificacion.txt #Genera el archivo de suma de verificación
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