// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
contract Multisender  {
    //Stores the employess address in array
    address payable [] public Employees; 

    constructor(address payable [] memory _addrs) {
        for(uint i=0; i<_addrs.length; i++){
            Employees.push(_addrs[i]);
        }
    }
    event PaymentReceived(address _from, uint _amount);

    //recieve function is to get the ether from SENDER 
    receive() payable external {
        //transfers the equal ammount of ether for number of employess
        uint256 share = msg.value / Employees.length; 

        for(uint i=0; i < Employees.length; i++){
            Employees[i].transfer(share);
        }    
        //emits the information about sender and How much he sends to contract
        emit PaymentReceived(msg.sender, msg.value);
    }      
}