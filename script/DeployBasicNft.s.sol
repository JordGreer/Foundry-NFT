// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "src/BasicNft.sol";

/*
        This script is meant to setup our deployment in a
    way that is chain agnostic.  We can create and import
    a helper config file to give settings for deployment 
    to Sepolia, Mainnet, Goerli, etc.

*/

contract DeployBasicNft is Script {
    /* 
    @dev Deploy contract object using Forge vm.
    We will call run() in our test contract (child) to 
    return a contract object to test with.
    */

    function run() external returns (BasicNft) {
        vm.startBroadcast();
        BasicNft basicNft = new BasicNft();
        vm.stopBroadcast();
        return basicNft;
    }
}
