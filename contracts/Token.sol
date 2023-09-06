// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// write a smart contract to create your own token on a local HardHat network. Once you have your contract, 
// you should be able to use remix to interact with it. 
// From remix, the contract owner should be able to mint tokens to a provided address. 
// Any user should be able to burn and mint tokens.

contract Token{
    string public name;
    string public symbol;
    uint256 public totalSupply;


    mapping (address => uint256) private balance;
    address private owner;

    // Events for Transfer, Burn and Mint Tokens
    event TransferTokens(address indexed sender, address indexed receiver, uint256 tokens);
    event BurnTokens(address indexed sender, uint256 tokens);
    event MintTokens(address indexed receiver, uint256 tokens);

    //  Constructor definition
    constructor(string memory _name, string memory _symbol, uint256 _totalsupply){
        name = _name;
        symbol = _symbol;
        totalSupply = _totalsupply;
        balance[msg.sender] = _totalsupply;
        owner = msg.sender;
    }

    // Functions for Transfer, Burn and Mint tokens

    // to transfer tokens
    function transferTokens(address _receiver, uint256 tokens) public returns (bool success){
        require(balance[msg.sender] >= tokens, "Insufficient tokens in your account");
        require(_receiver != address(0), "Invalid address");        // address(0) === null addresss

        balance[msg.sender] -= tokens;
        balance[_receiver] += tokens;
        emit TransferTokens(msg.sender, _receiver, tokens);
        return true;
    }

    // to burn tokens 
    function burnTokens(uint256 tokens) public returns (bool success){
        require(balance[msg.sender] >= tokens, "Insufficient tokens!");
        
        balance[msg.sender] -= tokens;
        totalSupply -= tokens;
        emit BurnTokens(msg.sender, tokens);

        return true;

    }

    // to check balance 
    function getBalance(address _account) public view returns (uint256) {
        return balance[_account];
    }


    // to mint tokens
    function mintTokens(address _receiver, uint256 tokens) public returns (bool success){
        require(msg.sender == owner, "Only the contract owner can Mint");
        require(_receiver != address(0), "Invalid Address");

        balance[_receiver] += tokens;
        totalSupply += tokens;
        emit MintTokens(_receiver, tokens);

        return true;
    }
}
