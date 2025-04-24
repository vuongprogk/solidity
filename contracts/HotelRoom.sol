// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom {
    // Ether payments
    // Modifiers
    // Visibility
    // Events
    // Enums
    enum Statuses {
        Vacant,
        Occupied
    }

    // adding event 
    event Occupy(address _occupant, uint _value);

    // defind attribute of contract
    Statuses public currentStatus;
    address payable public owner; // payable let address recevie payment;

    constructor() {
        owner = payable(msg.sender); // msg.sender is global variable let me know about who create this contract
        currentStatus = Statuses.Vacant;
    }

    // modifier like middleware handler before come handler
    modifier onlyVacant() {
        require(currentStatus == Statuses.Vacant, "Currently Occupied.");
        _;
    }
    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not enough ether provided.");
        _;
    }

    function book() external payable onlyVacant costs(2 ether) {
        currentStatus = Statuses.Occupied;
        // owner.transfer(msg.value); // sender who call this have to pay for currency for contract;
        // // msg.value is amount of ether when send to this function
        (bool send, bytes memory data) = payable (owner).call{value: msg.value}("");
        require(send == true, "Not booking yet");
        emit Occupy(msg.sender, msg.value);
    }
}

