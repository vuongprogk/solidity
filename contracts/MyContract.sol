// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address owner;
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Must be owner");
        _;
    }
}
contract SecretVault {
    string secret;
    constructor(string memory _secret) {
        secret = _secret;
    }
    function getSecret() public view returns (string memory) {
        return secret;
    }
}

contract MyContract is Ownable {
    // inheritance
    // factories
    // interaction
    address secret;

    constructor(string memory _secret) {
        SecretVault _secretVault = new SecretVault(_secret);
        secret = address(_secretVault);
        super;
    }
    function getSecret() public view onlyOwner returns (string memory) {
        return SecretVault(address(secret)).getSecret();
    }
}
