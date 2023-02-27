FROM node:alpine as build

ARG BUILD_DATE="1970-01-01T00:00:00Z"
ARG VCS_REF="local"
ARG VERSION="SNAPSHOT"
ARG NODE_ENV="production"

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install


FROM node:alpine
ARG NODE_ENV="production"

WORKDIR /usr/src/app
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY app/. .

ENTRYPOINT [ "node", "server.js" ]
