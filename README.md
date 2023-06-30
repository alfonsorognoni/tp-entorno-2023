# TP entorno 2023!

Reposorio trabajo práctico entorno de programación 2023.
TUIA, Comision 1
Integrantes:
|Alumno|Legajo |
|--|--|
|Alumno1|Legajo1|
|Alumno2|Legajo2|

# Qué hace?

En este repositorio encontrarán los archivos necesarios para generar un contenedor de Docker que al iniciar muestra un menú con diferentes acciones.

- Genera imágenes utilizando un servicio web en un archivo de compresión
- Permite descomprimir las imágenes generadas
- Permite procesar y recortar las imágenes
- Permite comprimir las imágenes procesadas y genera los siguientes archivos:
  - genera un archivo con la lista de nombres de todas las imágenes.
  - genera un archivo con la lista de nombres válidos.
  - genera un archivo con el total de personas cuyo nombre finaliza con la letra a.
  - genera un archivo comprimido que incluya los archivos generados en los items anteriores y todas las imágenes.

# Como se ejecuta?

- Se debe clonar el repositorio
- en un terminal y situados en la carpeta del repositorio ejcutar el comando para construir la imagen del contenedor:
  ` docker build --no-cache -t <nombre de la imagen> .`
  Por ejemplo: `docker build --no-cache -t tp-entorno .`
- Iniciar el contenedor y compartir los scripts
  `docker run -it -v ./scripts/:/scripts tp-entorno` (reemplazar "tp-entorno" por el nombre de la imagen)
