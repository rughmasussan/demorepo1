FROM node:lts-stretch-slim
WORKDIR /app
COPY package.json  .npmrc ./
RUN npm config set unsafe-perm true
USER root
COPY sonar-project.js ./
RUN apt-get update && apt-get install git -y
# RUN npm i npm@latest -g
RUN npm install sonarqube-scanner --save-dev
RUN npm install
COPY . /app
ENV CI=true
RUN npm run test
RUN npm run sonar
