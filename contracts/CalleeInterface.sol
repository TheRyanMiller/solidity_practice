pragma solidity ^0.4.19;

contract CalleeInterface {
    function getValue(uint initialValue) public returns(uint);
    function storeValue(uint value) public;
    function getValues() public view returns(uint);
}
