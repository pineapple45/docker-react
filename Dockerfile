FROM node:14-alpine as builder

WORKDIR /home/node/app
# RUN chown -R node:node /home/node/app

COPY package.json .
RUN npm install
COPY . .

# USER node

RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /home/node/app/build /usr/share/nginx/html