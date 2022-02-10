// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
  
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/token/ERC20/ERC20.sol";
import "./Whitelist.sol";
  
/**  
* @title BearToken is a basic ERC20 Token  
*/  
contract TestToken is ERC20, Whitelist {
    uint256 _totalSupply;
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    constructor(string memory name, string memory symbol, uint256 total) ERC20(name, symbol) {
        _mint(msg.sender, 100 * 10**uint(decimals()));
        _totalSupply = total;
        balances[msg.sender] = _totalSupply;
    }

    function Deposit(address receiver,uint numTokens) public returns (bool){
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - numTokens;
        balances[receiver] = balances[receiver] + numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        DepositFunds(msg.sender,numTokens,receiver);
        return true;
    }
}
