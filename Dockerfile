FROM node:16-alpine as builder

WORKDIR /home/node/app
RUN chown -R node:node /home/node/app

COPY --chown=node:node package.json .
RUN npm install
COPY --chown=node:node . .

USER node

RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /home/node/app/build /usr/share/nginx/html