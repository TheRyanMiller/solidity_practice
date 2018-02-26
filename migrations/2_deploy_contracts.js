var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var Voting = artifacts.require("./Voting.sol");
var HodlEthereum = artifacts.require("./HodlEthereum.sol");
var Callee = artifacts.require("./Callee.sol");
var CalleeInterface = artifacts.require("./CalleeInterface.sol");
var Caller = artifacts.require("./Caller.sol");

module.exports = function(deployer) {
  //deployer.deploy(ConvertLib);
  //deployer.link(ConvertLib, MetaCoin);
  //deployer.deploy(MetaCoin);
  //deployer.deploy(Voting, 1000, web3.toWei('0.1', 'ether'), ['Ryan Miller', 'Donald Trump', 'Hillary Clinton', 'Vitalik Buterin']);
  //deployer.deploy(HodlEthereum);
  deployer.deploy(Callee);
  //deployer.deploy(CalleeInterface);
  deployer.deploy(Caller);
};
