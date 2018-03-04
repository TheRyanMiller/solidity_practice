pragma solidity ^0.4.19;

contract HodlEthereum {

    event Hodl(address indexed hodler, uint indexed amount);
    event Release(address indexed hodler, uint indexed amount);

    mapping (address => uint) public hodlers;
    //uint constant targetTime = 8; // block num
    uint constant targetBlock = 2;

    function deposit() public payable {
        hodlers[msg.sender] += msg.value;
        Hodl(msg.sender, msg.value);
    }

    function release() public{
        require (block.number >= targetBlock && hodlers[msg.sender] > 0);
        uint value = hodlers[msg.sender];
        hodlers[msg.sender] = 0;
        msg.sender.transfer(value);
        Release(msg.sender, value);
    }

    function getBalance(address hodler) public view returns (uint){
      return hodlers[hodler];
    }
}
