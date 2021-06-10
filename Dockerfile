FROM node:14-alpine

WORKDIR /app

COPY package*.json ./

RUN rm -rf package-lock.json node_modules
RUN npm install

COPY . .

EXPOSE 3000

CMD npm run start
