# 1st Stage. Each stage can have only one FROM statement
# FROM node:alpine as builder 
FROM node:alpine 
WORKDIR '/app'
COPY package.json .
RUN npm install
# We don't need volume mapping because we are not change code in production
COPY . .
RUN npm run build
     
# 2nd Stage. The next FROM statement terminates the previous stage.
# --from=builder We are copying from previous stage
FROM nginx
# COPY --from=builder /app/build /usr/share/nginx/html
COPY --from=0 /app/build /usr/share/nginx/html
# nginx image has a default command to start nginx. We don't have to specify it.