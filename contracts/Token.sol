// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token{
    string public name;
    string public symbol;
    uint256 public totalSupply;


    mapping (address => uint256) private balance;
    address private owner;

    // Events for Transfer, Burn and Mint REX
    event TransferREX(address indexed sender, address indexed receiver, uint256 REX);
    event BurnREX(address indexed sender, uint256 REX);
    event MintREX(address indexed receiver, uint256 REX);

    //  Constructor definition
    constructor(string memory _name, string memory _symbol, uint256 _totalsupply){
        name = _name;
        symbol = _symbol;
        totalSupply = _totalsupply;
        balance[msg.sender] = _totalsupply;
        owner = msg.sender;
    }

    // Functions for Transfer, Burn and Mint REX

    // to transfer REX
    function transferREX(address _receiver, uint256 REX) public returns (bool success){
        require(balance[msg.sender] >= REX, "Insufficient REX in your account");
        require(_receiver != address(0), "Invalid address");        // address(0) === null addresss

        balance[msg.sender] -= REX;
        balance[_receiver] += REX;
        emit TransferREX(msg.sender, _receiver, REX);
        return true;
    }

    // to burn REX 
    function burnREX(uint256 REX) public returns (bool success){
        require(balance[msg.sender] >= REX, "Insufficient REX!");
        
        balance[msg.sender] -= REX;
        totalSupply -= REX;
        emit BurnREX(msg.sender, REX);

        return true;

    }

    // to check balance 
    function getBalance(address _account) public view returns (uint256) {
        return balance[_account];
    }


    // to mint REX
    function mintREX(address _receiver, uint256 rex) public returns (bool success){
        require(msg.sender == owner, "Only the contract owner can Mint REX");
        require(_receiver != address(0), "Invalid Address");

        balance[_receiver] += rex;
        totalSupply += rex;
        emit MintREX(_receiver, rex);

        return true;
    }
}
