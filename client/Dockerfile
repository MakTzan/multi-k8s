#This is the build phase
#At the end of this phase we have the built app in the /build folder.
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#This is the run phase
#We take the output of the build phase , copy it to the nginx container and run nginx
FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html