#!/bin/bash

generar() {
    while true; do
        read -p "Ingresa el número de imágenes a generar: (-1 para volver)" num
        if [[ $num == "-1" ]]; then
            break
        elif [[ $num =~ ^[0-9]+$ ]]; then
                # num=$1
            link="https://source.unsplash.com/random/900%C3%97700/?person"
            # output_file="scripts/imagen.jpg"
            for ((i=1; i<=$num; i++)); do
                # ls -l "/compartir/imagenes" 
                wget "$link" -O "/compartir/imagenes/imagen$i.jpg"
                echo "Descargando imagen $i"
            done
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