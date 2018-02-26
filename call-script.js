var Web3 = require('web3');
const contract = require('truffle-contract');

if (typeof web3 !== 'undefined') {
  web3 = new Web3(web3.currentProvider);
} else {
  // set the provider you want from Web3.providers
  web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
}
const callerArtifacts = require('./build/contracts/Caller.json');
const caller = contract(callerArtifacts);
caller.setProvider(web3.currentProvider);

const calleeArtifacts = require('./build/contracts/Callee.json');
const callee = contract(calleeArtifacts);
callee.setProvider(web3.currentProvider);


/*---------------------------------------------------------------------
SCRIPTS BELOW
---------------------------------------------------------------------*/

var acct ="0x8bf4af49780711de580e4fa6a9dce4db4a8a2a95";
var calleeAddress = "0xbdacd90371d2985ace481952e9d65999514ad93e";
var callerAddress = "0x21a60bbaa3197e7d28797eb1fe1c5f335d40da30";
//var calleeInterfaceAddress = "0x41f2cef8b9e84db02df3ad8701f96d0dd8f9950c";

//DEPOSIT
/*
caller.deployed().then(function(contractInstance) {
  contractInstance.storeAction(calleeAddress, 12 , {value:web3.toWei(0, "ether"), from:acct, gas:2000000}).then(function(v) {
    console.log(v);
  });
});
*/

callee.deployed().then(function(contractInstance) {
  contractInstance.getValues({value:web3.toWei(0, "ether"), from:acct, gas:2000000}).then(function(v) {
    console.log(v);
  });
});

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
