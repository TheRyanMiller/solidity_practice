var Web3 = require('web3');
const contract = require('truffle-contract');

if (typeof web3 !== 'undefined') {
  web3 = new Web3(web3.currentProvider);
} else {
  // set the provider you want from Web3.providers
  web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
}
const hodlEthereumArtifacts = require('./build/contracts/HodlEthereum.json');
const hodlEthereum = contract(hodlEthereumArtifacts);
hodlEthereum.setProvider(web3.currentProvider);


/*---------------------------------------------------------------------
SCRIPTS BELOW
---------------------------------------------------------------------*/

var acct ="0xfb1bd2c12ef2f6eee6c547cc115d9afa1c70b9c7";
var contractAddress = "0x008baac49284b22ee8fc6504b256e00256fea7f8";

//DEPOSIT

hodlEthereum.deployed().then(function(contractInstance) {
  contractInstance.deposit({value:web3.toWei(72, "ether"), from:acct, gas:2000000}).then(function(v) {
    console.log(v);
  });
})
/*
hodlEthereum.deployed().then(function(contractInstance){
  console.log(contractInstance);
})
*/
//console.log(hodlEthereum)
//console.log(web3.eth.getBalance(contractAddress).toString()); //Check Balance of Contract

//CheckBalance
/*
hodlEthereum.deployed().then(function(contractInstance) {
  contractInstance.getBalance(acct,{from:acct, gas:2000000}).then(function(v) {
    console.log(v.toString())
  });
})
*/

//Release
/*
hodlEthereum.deployed().then(function(contractInstance) {
  contractInstance.release({from:acct, gas:2000000}).then(function(v) {
    console.log(v)
  });
})
*/
//npm run dev
