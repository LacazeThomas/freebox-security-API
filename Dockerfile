FROM node:14-alpine

WORKDIR /usr/

COPY ./ /usr/
RUN npm install

EXPOSE 8888

CMD ["npm", "start"]