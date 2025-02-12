// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol"; // updated import path
import {VulnerableContract} from "./VulnerableContract.sol"; // import VulnerableContract

struct CollectOutput {
    string text;
}

contract HelloWorldTrap is ITrap {
    VulnerableContract public vulnerableContract;
    bool public stopped = false;

    constructor(address _owner) {
        vulnerableContract = new VulnerableContract(_owner);
    }

    modifier stopInEmergency {
        require(!stopped, "Contract is stopped");
        _;
    }

    function checkOwnerChanged() external {
        address currentOwner = vulnerableContract.Owner();
        if (currentOwner != address(this)) {
            stopped = true;
        }
    }

    function collect() external view stopInEmergency returns (bytes memory) {
        return abi.encode(CollectOutput({text: "Hello World!"}));
    }

    function shouldRespond(
        bytes[] calldata data
    ) external pure stopInEmergency returns (bool, bytes memory) {
        for (uint256 i = 0; i < data.length; i++) {
            CollectOutput memory output = abi.decode(data[i], (CollectOutput));
            if (
                keccak256(abi.encodePacked(output.text)) ==
                keccak256(abi.encodePacked("Hello World, this is scofield!"))
            ) {
                return (true, bytes(abi.encode(output.text)));
            }
        }
        return (false, bytes(""));
    }
}

