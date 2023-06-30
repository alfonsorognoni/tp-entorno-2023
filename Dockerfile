# usar alpine linux
FROM alpine:latest

# instalar dependencias para los scripts bash
RUN apk update && apk add bash

# compartir directorio de scripts
VOLUME /scripts

# iniciar el menu de opciones
CMD ["/bin/bash", "/scripts/menu.sh"]
