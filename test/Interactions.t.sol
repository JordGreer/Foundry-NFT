//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "src/BasicNft.sol";

contract MintBasicNft is Script {
    string public constant URI_TO_MINT =
        "ipfs://QmYUuqPrgE8fRkAxpDjqcPqqoPYDz2iScNjneJfHYb9Vsy";

    function run() public {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );

        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(URI_TO_MINT);
        vm.stopBroadcast();
    }
}
