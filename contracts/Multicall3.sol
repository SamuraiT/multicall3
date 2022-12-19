// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/// @title Multicall3 - Aggregate results from multiple read-only function calls with delegatecall so that msg.sender remains caller's address
import "hardhat/console.sol";

contract Multicall3 {
    struct Call {
        address target;
        bytes callData;
    }

    struct Call2 {
        address target;
        string callData;
    }

    function aggregate(Call[] memory calls)
        public
        returns (uint256 blockNumber, bytes[] memory returnData)
    {
        blockNumber = block.number;
        returnData = new bytes[](calls.length);
        console.log(msg.sender);
        for (uint256 i = 0; i < calls.length; i++) {
            (bool success, bytes memory ret) = address(calls[i].target).delegatecall(
                calls[i].callData
            );
            require(success);
            returnData[i] = ret;
        }
    }

    function aggregate2(Call2[] memory calls)
        public
        returns (uint256 blockNumber, bytes[] memory returnData)
    {
        blockNumber = block.number;
        returnData = new bytes[](calls.length);
        console.log(msg.sender);
        for (uint256 i = 0; i < calls.length; i++) {
            (bool success, bytes memory ret) = address(calls[i].target).delegatecall(
                abi.encodeWithSignature(calls[i].callData)
            );
            require(success);
            returnData[i] = ret;
        }
    }
    // Helper functions
    function getEthBalance(address addr) public view returns (uint256 balance) {
        balance = addr.balance;
    }

    function getBlockHash(uint256 blockNumber)
        public
        view
        returns (bytes32 blockHash)
    {
        blockHash = blockhash(blockNumber);
    }

    function getLastBlockHash() public view returns (bytes32 blockHash) {
        blockHash = blockhash(block.number - 1);
    }

    function getCurrentBlockTimestamp()
        public
        view
        returns (uint256 timestamp)
    {
        timestamp = block.timestamp;
    }

    function getCurrentBlockDifficulty()
        public
        view
        returns (uint256 difficulty)
    {
        difficulty = block.difficulty;
    }

    function getCurrentBlockGasLimit() public view returns (uint256 gaslimit) {
        gaslimit = block.gaslimit;
    }

    function getCurrentBlockCoinbase() public view returns (address coinbase) {
        coinbase = block.coinbase;
    }
}
