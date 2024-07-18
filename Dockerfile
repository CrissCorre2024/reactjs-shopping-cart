# Utilizar una imagen base más reciente y mantenida de Node.js
FROM node:16

# Crear directorio de la aplicación
WORKDIR /usr/src/app

# Instalar dependencias de la aplicación
# Se usa un comodín para asegurar que se copian tanto package.json como package-lock.json
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
