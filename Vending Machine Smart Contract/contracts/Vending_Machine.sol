// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract VendingMachine {
    address public owner;
    mapping (address => uint) public chipsBalances;

    constructor() {
        owner = msg.sender;
        chipsBalances[ address (this)] = 100;
    }

    function getVendingMachineBalance() public view returns(uint){
        return chipsBalances[address (this)];
    }

    function restock(uint stockAmount) public {
        require(msg.sender == owner, "Only the owner can update this Machine.");
        chipsBalances[address(this)] += stockAmount;
    }

    function purchaseChips(uint purchaseAmount) public payable {
        require(msg.value >= purchaseAmount * 0.01 ether, "You must pay at least 0.01 ETH per chip.");
        require(chipsBalances[address(this) ] >= purchaseAmount, " No stock for chips");

        chipsBalances[address(this)] -= purchaseAmount;
        chipsBalances[msg.sender] += purchaseAmount;
    }
}