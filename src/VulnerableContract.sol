
pragma solidity ^0.8.12;

contract VulnerableContract {
    address public Owner;

    // Constructor to set the initial owner
    constructor(address _owner) {
        Owner = _owner;
    }

    // Function to change the owner (no access control)
    function changeOwner(address _newOwner) public {
        Owner = _newOwner;
    }
}