// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
contract Multisender  {
    //Stores the employess address in array
    address[] public Employees; 
    address payable public owner;
    uint public share;
        constructor(){
         owner = payable(msg.sender);   
        }
    function AddEmployee(address _addrs) public {
       Employees.push(_addrs);
    }
    event PaymentReceived(address _from, uint _amount);

    //recieve function is to get the ether from SENDER 
    receive() payable external {
                 
    }      
    function Transfer() payable public{
        //transfers the equal ammount of ether for number of employess
        share = address(this).balance / Employees.length;
         for(uint i=0; i < Employees.length; i++){
            (bool sent,)=payable(Employees[i]).call{value:share}("");
            require(sent,"Transfer Failed");
        }    
        //emits the information about sender and How much he sends to contract
        emit PaymentReceived(msg.sender, address(this).balance);
    } 
}
