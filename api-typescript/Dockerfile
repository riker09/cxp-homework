FROM node:18-alpine AS build

WORKDIR /app

ADD . .

RUN npm ci --no-audit --no-fund \
    npm run build


FROM node:18-alpine

WORKDIR /app

ADD package*.json .

RUN npm ci --no-audit --no-fund --production

COPY --from=build /app/dist /app

RUN chown 1000:1000 -R .

USER 1000

EXPOSE 8080

CMD ["npm", "run", "start"]
