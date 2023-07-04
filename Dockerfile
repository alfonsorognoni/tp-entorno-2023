# usar alpine linux
FROM alpine:latest

# instalar dependencias para los scripts bash
RUN apk update && apk add bash

# compartir directorio
VOLUME /compartir

# iniciar el menu de opciones
CMD ["/bin/bash", "/compartir/scripts/menu.sh"]
