// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract MockStaking {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public counter;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function increment() public {
        counter[msg.sender] += 1;
    }

    function getCounter() public view returns (uint256) {
        console.log('hoge');
        console.log(msg.sender);
        console.log(counter[msg.sender]);
        console.log('hoge');
        return counter[msg.sender];
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
