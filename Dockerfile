# Step 1: Use a Node.js image to build the React app
FROM node:20 as build

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Use a lightweight web server to serve the React app
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]
