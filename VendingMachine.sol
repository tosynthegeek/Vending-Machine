// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract VendingMachine {

    address public owner;
    mapping (address => uint) public dountBalances;

    constructor () {
        owner = msg.sender;
        dountBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns (uint){
        return dountBalances[address(this)];
    }

    function restockVendingMaching(uint amount) public {
        require(msg.sender == owner, "Sender does not have this permission");
        dountBalances[address(this)] += amount;
    }

    function purchase (uint amount) public payable {
        require(msg.value >= amount * 2 ether, "Not enough ether");
        require(dountBalances[address(this)] > amount, "Not enough donut, wait for restock");
        dountBalances[address(this)] -= amount;
        dountBalances[msg.sender] += amount;
    }
}