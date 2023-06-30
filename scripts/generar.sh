#!/bin/bash

generar() {
    while true; do
        read -p "Ingresa el número de imágenes a generar: (-1 para volver)" num
        if [[ $num == "-1" ]]; then
            break
        elif [[ $num =~ ^[0-9]+$ ]]; then
            break
        else
            echo "Ingresa un número válido"
        fi
        read -p "Presiona Enter para continuar..."
    done
    # num=$1
    link="https://source.unsplash.com/random/900%C3%97700/?person"

    for ((i=1; i<=$num; i++)); do
        # curl -s $link | grep -o 'https://images.unsplash.com/photo-[a-zA-Z0-9]*' | head -n $i | tail -n 1 | xargs wget -qO "image$i.jpg"
        echo "Descargando imagen $i"
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