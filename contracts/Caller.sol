pragma solidity ^0.4.19;

import "./CalleeInterface.sol";

contract Caller {
    function someAction(address addr) returns(uint) {
        CalleeInterface c = CalleeInterface(addr);
        return c.getValue(100);
    }

    function storeAction(address addr, uint number) returns(uint) {
        CalleeInterface c = CalleeInterface(addr);
        c.storeValue(number);
        return c.getValues();
    }

    function someUnsafeAction(address addr) {
        addr.call(bytes4(keccak256("storeValue(uint256)")), 100);
    }
}
