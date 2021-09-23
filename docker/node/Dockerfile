FROM alpine:latest

RUN apk add npm nodejs curl openssl ca-certificates vim

COPY ./node /node
WORKDIR /node
RUN npm install
CMD node indexhttp1.js