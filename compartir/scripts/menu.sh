#!/bin/bash

# Para dar permisos de ejecución a todos los scripts
chmod +x compartir/**/*.sh

while true; do
    clear
    echo "Menú Principal"
    echo "----------------"
    echo "1. Generar imagenes"
    echo "2. Descomprimir imagenes"
    echo "3. Procesar imagenes"
    echo "4. Comprimir imagenes"
    echo "5. Salir"

    read -p "Ingresa una opción: " option

    case $option in
        1) compartir/scripts/generar.sh ;;
        2) ./descomprimir.sh ;;
        3) compartir/scripts/procesar.sh ;;
        4) compartir/scripts/comprimir.sh ;;
        5) exit ;;
        *) clear && echo "Opción inválida" ;;
    esac
    read -p "Presiona Enter para continuar..."
done