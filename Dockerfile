FROM node:14.19.3-alpine as build
WORKDIR /nodejs-kant-app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run lint && npm run build


FROM node:14.19.3-alpine
ARG SERVICE_PORT=3888
WORKDIR /nodejs-kant-app
COPY --from=build /nodejs-kant-app/dist ./
CMD node index.js
EXPOSE ${SERVICE_PORT}