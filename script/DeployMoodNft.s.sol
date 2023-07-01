//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory sadSvg = vm.readFile("./img/Sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");
        /* console.log("sadSvg", sadSvg);
        console.log("happySvg", happySvg); */

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgToImageURI(sadSvg),
            svgToImageURI(happySvg)
        );
        vm.stopBroadcast();

        return moodNft;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        /*example input
         <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xl.....etc */

        //Prefix of output - bause url is known
        string memory baseURL = "data:image/svg+xml;base64,";

        //Postfix of output - Base 64 encode the bytes of the svg
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );

        // Return the full URI -  essentially concating
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
