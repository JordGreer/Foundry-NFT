//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {BasicNft} from "src/BasicNft.sol";
import {Test} from "forge-std/Test.sol";
import {MintBasicNft} from "script/Interactions.s.sol";

contract BasicNFTTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;

    address public USER = makeAddr("user");

    string public constant URI_TO_MINT =
        "ipfs://QmeavoNbEZGTcMs3yNqU9eS8kYZasR6hRCmgs5ns6fDsUs";

    /* Think in terms of context of this file.  Its being run 
    by forge testing.  So This function will be run before 
    every test.  This will create a new contract object to
    test by using the deployer.run() from the deploying script.
    -----------------------------------------------------
        vm.startBroadcast();
        BasicNft basicNft = new BasicNft();
        vm.stopBroadcast();
        return basicNft;
    -----------------------------------------------------

    Running the vm in forge that deploys the contract and
    then returns the contract object to this test file.
     */

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expected = "Dogie";
        string memory actual = basicNft.name();

        /* 
            This is comparing the hash (32 bytes) of 
            the bytes encoded in the abi format.
            This is because we cannot compare two strings, 
            which are dynamic types.  We need to compare
            the hashs of encoded data strings.
            
         */

        assert(
            keccak256(abi.encodePacked(expected)) ==
                keccak256(abi.encodePacked(actual))
        );
    }

    function testCanMintAndHaveABallance() public {
        vm.prank(USER);
        basicNft.mintNft(URI_TO_MINT);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(URI_TO_MINT)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
