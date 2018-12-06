# Multi Step Process:
# 1. build
# 2. run

# Build Phase
FROM node:alpine as builder
WORKDIR /app
COPY package.json package.json
RUN npm install
COPY . .
RUN npm run build

# Run Phase
FROM nginx
# Used by Elastic Beanstalk to map directly incoming traffic
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
