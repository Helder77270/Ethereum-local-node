# Ethereum-local-node

solc -o target --bin --abi Greeter.sol : Permet de compiler le contrat depuis la machine hote afin de ne pas avoir à le faire dans la machine serveur

Ensuite nous le compilons le dockerfile et nous lancons l’image : 

“build -t <nom_de container> .”

“docker run -it <nom_de container ou id_image_docker>”


“geth --datadir . account new” --datadir nous permet de spécifier un dossier précis où enregistrer nos clés car par défaut sur Linux geth va chercher un dossier ./ethereum qui n’existe pas dans notre container.
Un mot de passe vous sera demandé, choisissez le et ne l’oubliez pas !

Dans la console s’affiche, une adresse que l’on devra ajouter dans le fichier genesis.json à la place de la balise : <une_certaine_adresse>

geth --datadir . init genesis.json : Avec geth, on initialise la blockchain avec comme fichier de conf, genesis.json

geth --rpc --rpcaddr localhost --rpcport 6666 --rpcapi "personal,eth,web3,net" --datadir . console --allow-insecure-unlock : TBD

eth.getBalance(eth.coinbase) : Cette commande permet de récupérer le nombre d’Eth possédé par l’adresse que nous avons instanciée dans le fichier genesis.json à la ligne coinbase (normalement à 0 au départ)



miner.start() : Démarre le minage de block > laissez 4-5 minutes le emps que les premiers blocs se minent - faites un miner.stop() et lancez la commande : eth.getBalance(eth.coinbase) > Devrait donner un nombre supérieur à 0 (peut-être même un très grand nombre)

Toujours dans la console mettre les fichiers dans des variables :

mainHex = (coller le contenu du .bin générez lors de la compilation du smart contract)
mainAbi = (coller le contenu du .abi générez lors de la compilation du smart contract)
mainInterface = eth.contract(mainAbi)

Publier le contrat :
Maintenant que nos variables sont définies c’est l’heure de déployer notre contrat sur notre blockchain local
Voici la commande pour déployer le contrat :
var mainTx = mainInterface.new(
  {
    from: eth.accounts[0],
    data: mainHex,
    gas: 1000000
  }
)
If you get an error during this step about needing to unlock your account, do personal.listAccounts[0],"<le_mot_de_passe choisit>", 15000 and enter your passphrase

Si vous avez une erreur pendant cette étape, faites personal.unlockAccount(“<coinbase_address>”,”<mot_de_passe_choisit>”)

mainTxHash = mainTx.transactionHash : Donne le hash de la transaction de création du contrat


txpool.status : Doit afficher ceci, cela veut dire que le déploiement est en cours :



eth.getTransactionReceipt(mainTxHash) :
Miner.start() attendre quelques secondes
