# Trabajo Práctico Final - Entorno de Programación - 2023

Repositorio del trabajo práctico final de 'Entorno de programación' 2023.
TUIA, Comisión 1
Integrantes:
|Alumno|Legajo |
|--|--|
|Nancy Lucía Cima|C-7379/2|
|Alfonso Rognoni|R-4630/2|

# Funciones

Este es programa permite procesar un lote de imágenes.

 Con este programa puede:
- Generar imágenes  en un archivo de compresión.
- Descomprimir las imágenes generadas.
- Procesar y recortar las imágenes
- Comprimir las imágenes procesadas y generar los siguientes archivos:
  - un archivo de texto con una lista de los nombres de todas las imágenes.
  - un archivo de texto con una lista de los nombres de las imágenes que sean válidos (que empiecen con una letra mayúscula y sigan con letras minúsculas.).
  - un archivo de texto con el total de personas cuyo nombre finaliza con la letra a.
  - un archivo comprimido que incluya los archivos generados en los ítems anteriores y todas las imágenes.

# Contenido

En este repositorio encontrará los archivos necesarios para generar un contenedor de Docker que al iniciar muestra un menú con diferentes acciones.

En particular, encontrará los siguientes archivos:

- Dockerfile: Genera un contenedor de Docker con las dependencias necesarias.
- generar.sh: Genera imágenes utilizando un servicio web. Se indica por
argumento cuantas imágenes generar y se les asignan nombres de personas
al azar. Devuelve las imágenes comprimidas y un archivo de texto con una suma
de verificación.
- descomprimir.sh: Recibe por argumento dos archivos (uno
con las imágenes comprimidas y otro con una suma de verificación). Si la suma
de verificación de ambos archivos coincide procede a descomprimir las imágenes.
- procesar.sh: Recortar las imágenes que tengan nombres de personas válidos a
una resolución de 512*512.
- comprimir.sh: Genera varios archivos de texto cada uno con una lista de nombres
de imágenes que siguen cierto patrón. También, genera un archivo comprimido que
incluya los archivos generados y todas las imágenes.
- menu.sh: Imprime un menú que permite ejecutar cada uno de los archivos anteriores.
- nombres.csv: Lista de nombres de personas que se usara en generar.sh.

# Ejecución

Para ejecutar este programa:
- Debe clonar este repositorio localmente
- Situarse en la carpeta donde clono el repositorio y abrir una terminal
- Ejecutar el siguiente comando que construirá una imagen del contenedor:
  ` docker build --no-cache -t <nombre de la imagen> .`
  Por ejemplo: `docker build --no-cache -t tp-entorno .`
- Iniciar el contenedor y compartir los scripts corriendo el siguiente comando
  `docker run -it -v ./compartir/:/compartir <nombre de la imagen> ` (Recuerde reemplazar "<nombre de la imagen>" por el nombre que le asigno a su imagen en el paso anterior.)

# Versiones

Este proyecto está en desarrollo actualmente. Publicaremos nuevas versiones en el futuro.

# Licencia

Puede encontrar la licencia del proyecto en este repositorio.

# Autores

Este programa fue desarrollado por Nancy Lucía Cima y Alfonso Rognoni.