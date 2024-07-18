# Utilizar una imagen base más reciente y mantenida de Node.js
FROM node:20.15.1-bookworm-slim

# Actualizar paquetes del sistema para mitigar vulnerabilidades
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    python3.7=3.7.3-2+deb10u6 \
    python3.7-minimal=3.7.3-2+deb10u6 \
    git=1:2.20.1-2+deb10u9 \
    libdb5.3=5.3.28+dfsg1-0.5 \
    zlib1g=1:1.2.11.dfsg-1+deb10u3 \
    libde265-0=1.0.11-0+deb10u6 \
    libnghttp2-14=1.36.0-2+deb10u2 \
    libcurl4-openssl-dev=7.64.0-4+deb10u9 \
    curl=7.64.0-4+deb10u9 \
    libncurses5-dev=6.1+20181013-2+deb10u5 \
    libwebp-dev=0.6.1-2+deb10u3 \
    libpq-dev=11.22-0+deb10u1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Crear directorio de la aplicación
WORKDIR /usr/src/app

# Instalar dependencias de la aplicación
COPY package*.json ./
RUN npm install
# Si se está construyendo el código para producción
# RUN npm ci --only=production

# Copiar el código fuente de la aplicación
COPY . .

# Establecer el mantenedor
LABEL maintainer="malevarro.sec@gmail.com"

# Establecer un chequeo de salud para el contenedor
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl --fail http://localhost:3000/ || exit 1

# Indicar a Docker el puerto que debe exponer
EXPOSE 3000

# Comando para ejecutar la aplicación
CMD ["npm", "start"]
