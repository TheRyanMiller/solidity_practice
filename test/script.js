var Web3 = require('web3');
const contract = require('truffle-contract');

if (typeof web3 !== 'undefined') {
  web3 = new Web3(web3.currentProvider);
} else {
  // set the provider you want from Web3.providers
  web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));
}

const hodlEthereumArtifacts = require('../build/contracts/HodlEthereum.json');
const hodlEthereum = contract(hodlEthereumArtifacts);
//console.log(hodlEthereum);
hodlEthereum.setProvider(web3.currentProvider);
//console.log(hodlEthereum.deployed().then());
//var acct ="0xC5fdf4076b8F3A5357c5E395ab970B5B54098Fef";
acct ="0x627306090abaB3A6e1400e9345bC60c78a8BEf57";
// contract at : 0xf204a4ef082f5c04bb89f7d5e6568b796096735a
//Send to contract

//DEPOSIT
/*
hodlEthereum.deployed().then(function(contractInstance) {
  contractInstance.deposit({value:web3.toWei(91, "ether"), from:acct, gas:2000000}).then(function(v) {
    console.log(v)
  });
})
*/

//CheckBalance
/*
hodlEthereum.deployed().then(function(contractInstance) {
  contractInstance.getBalance(acct,{from:acct, gas:2000000}).then(function(v) {
    console.log(v.toString())
  });
})
*/

//Release

hodlEthereum.deployed().then(function(contractInstance) {
  contractInstance.release({from:acct, gas:2000000}).then(function(v) {
    console.log(v)
  });
})
