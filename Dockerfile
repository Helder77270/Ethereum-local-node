FROM ubuntu AS builder

RUN apt update
RUN apt-get install software-properties-common -y
RUN add-apt-repository -y ppa:ethereum/ethereum
RUN apt update
RUN apt install ethereum -y

#smart contract
RUN apt install nodejs -y
RUN apt install npm -y
RUN apt install -y solc
RUN apt install nano -y

WORKDIR Projet
COPY . .

FROM alpine

COPY --from=0 ./Project ./Project 
