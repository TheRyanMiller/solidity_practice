pragma solidity ^0.4.11;

contract HodlEthereum {
    event Hodl(address indexed hodler, uint indexed amount);
    event Release(address indexed hodler, uint indexed amount);
    mapping (address => uint) public hodlers;
    uint constant targetTime = 8; // block num
    uint constant targetBlock = 8;

    function deposit() public payable {
        hodlers[msg.sender] += msg.value;
        Hodl(msg.sender, msg.value);
    }

    function release() public{
        require (10 >= targetBlock && hodlers[msg.sender] > 0);
        uint value = hodlers[msg.sender];
        hodlers[msg.sender] = 0;
        msg.sender.transfer(value);
        Release(msg.sender, value);
    }

    function getBalance(address hodler) public view returns (uint){
      uint balance = hodlers[hodler];
      return balance;
    }
}
