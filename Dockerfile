# Use a more recent Node.js LTS base image
FROM node:16

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm ci --only=production

# Bundle app source
COPY . .

# Set maintainer
LABEL maintainer="malevarro.sec@gmail.com"

# Set a health check
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -f http://localhost:3000/ || exit 1

# Tell Docker what port to expose
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
