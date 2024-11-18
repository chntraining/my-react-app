FROM node:20-alpine AS build
WORKDIR /my-react-app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /my-react-app/build /usr/share/nginx/html
RUN chmod -R 775 /usr/share/nginx/html/static
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 81
CMD ["nginx", "-g", "daemon off;"]
