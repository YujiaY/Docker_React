FROM node:16-alpine
WORKDIR /opt/ng
COPY package.json .
RUN npm install

ENV PATH="./node_modules/.bin:$PATH"

COPY . .

RUN ng build --prod

FROM nginx:1.18-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
COPY --from=0 /opt/ng/dist/angular-universal-app/browser /usr/share/nginx/html
