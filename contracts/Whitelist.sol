// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract Whitelist {

    address owner;

    mapping(address => bool) whitelistedAddresses;
    struct Deposits { 
          address from;
          uint256 amount;
          address tokenAddress;
      }

    constructor() {
      owner = msg.sender;
    }

    modifier onlyOwner() {
      require(msg.sender == owner, "Ownable: caller is not the owner");
      _;
    }

    modifier isWhitelisted() {
      require(whitelistedAddresses[msg.sender], "Whitelist: You need to be whitelisted");
      _;
    }

    function addUser(address _addressToWhitelist) public onlyOwner {
      whitelistedAddresses[_addressToWhitelist] = true;
    }

    function verifyUser(address _whitelistedAddress) public view returns(bool) {
      bool userIsWhitelisted = whitelistedAddresses[_whitelistedAddress];
      return userIsWhitelisted;
    }

    function DepositFunds(address from,uint256 amount, address to ) public view isWhitelisted() returns(bool){
      Deposits(from,amount,to);
      return (true);
    }

}