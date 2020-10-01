FROM ubuntu 

RUN apt update 
RUN apt-get install software-properties-common -y 
RUN add-apt-repository -y ppa:ethereum/ethereum 
RUN apt update 
RUN apt install ethereum -y #smart contract 
RUN apt install nodejs -y 
RUN apt install npm -y 
RUN apt-get install solc -y

WORKDIR Projet
COPY . .
# = Commentaires
#RUN geth --datadir . account new 
#CMD ["geth", "--ropsten", "console"]