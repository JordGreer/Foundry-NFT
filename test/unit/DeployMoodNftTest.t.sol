//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "src/MoodNft.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployoodNftTest is Test {
    DeployMoodNft deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConvertSvgToUri() public view {
        //Arrange
        string
            memory expected = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA0NzMuOTMxIDQ3My45MzEiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDQ3My45MzEgNDczLjkzMSIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+PGNpcmNsZSBzdHlsZT0iZmlsbDojZmZjMTBlIiBjeD0iMjM2Ljk2NiIgY3k9IjIzNi45NjYiIHI9IjIzNi45NjYiLz48cGF0aCBzdHlsZT0iZmlsbDojZmZmIiBkPSJNODEuMzkxIDIzNy4xMjNjMCA4NS45MTEgNjkuNjQ5IDE1NS41NiAxNTUuNTYgMTU1LjU2IDg1LjkxNSAwIDE1NS41NjQtNjkuNjQ5IDE1NS41NjQtMTU1LjU2SDgxLjM5MXoiLz48cGF0aCBzdHlsZT0iZmlsbDojY2NjYmNiIiBkPSJNMTY3LjcyOCAyMzcuMTIzdjEzOS4zMDZhMTU0LjU1IDE1NC41NSAwIDAgMCAxOC43MDkgNy44MlYyMzcuMTIzaC0xOC43MDl6bTExNS41OTEgMHYxNDguNTI5YzYuNDMyLTIuMDA2IDEyLjY2Ni00LjQ1MyAxOC43MDktNy4yNFYyMzcuMTIzaC0xOC43MDl6Ii8+PHBhdGggc3R5bGU9ImZpbGw6IzMzMyIgZD0iTTIxOS4xODEgMTU4Ljc5M2MtMS42ODQtMzEuMjU1LTIzLjk5Mi01My41Ni01NS4yNDMtNTUuMjQzLTMxLjE4NC0xLjY4LTUzLjY5OCAyNi41MjItNTUuMjQzIDU1LjI0My0uNjUxIDEyLjA2MyAxOC4wNjEgMTIgMTguNzA5IDAgMi41MzctNDcuMDkgNzAuNTM2LTQ3LjA5IDczLjA2OSAwIC42NDcgMTIgMTkuMzU5IDEyLjA2MyAxOC43MDggMHptMTM0LjgwNCAwYy0xLjY4NC0zMS4yNTUtMjMuOTkyLTUzLjU2LTU1LjI0My01NS4yNDMtMzEuMTg0LTEuNjgtNTMuNjk0IDI2LjUyMi01NS4yNDMgNTUuMjQzLS42NTEgMTIuMDYzIDE4LjA2MSAxMiAxOC43MDkgMCAyLjUzNy00Ny4wOSA3MC41MzItNDcuMDkgNzMuMDY5IDAgLjY0NyAxMiAxOS4zNiAxMi4wNjMgMTguNzA4IDB6Ii8+PC9zdmc+";
        string
            memory svg = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 473.931 473.931" style="enable-background:new 0 0 473.931 473.931" xml:space="preserve"><circle style="fill:#ffc10e" cx="236.966" cy="236.966" r="236.966"/><path style="fill:#fff" d="M81.391 237.123c0 85.911 69.649 155.56 155.56 155.56 85.915 0 155.564-69.649 155.564-155.56H81.391z"/><path style="fill:#cccbcb" d="M167.728 237.123v139.306a154.55 154.55 0 0 0 18.709 7.82V237.123h-18.709zm115.591 0v148.529c6.432-2.006 12.666-4.453 18.709-7.24V237.123h-18.709z"/><path style="fill:#333" d="M219.181 158.793c-1.684-31.255-23.992-53.56-55.243-55.243-31.184-1.68-53.698 26.522-55.243 55.243-.651 12.063 18.061 12 18.709 0 2.537-47.09 70.536-47.09 73.069 0 .647 12 19.359 12.063 18.708 0zm134.804 0c-1.684-31.255-23.992-53.56-55.243-55.243-31.184-1.68-53.694 26.522-55.243 55.243-.651 12.063 18.061 12 18.709 0 2.537-47.09 70.532-47.09 73.069 0 .647 12 19.36 12.063 18.708 0z"/></svg>';
        //Act
        string memory actual = deployer.svgToImageURI(svg);

        //access the openzeppelin library directly to debug
        console.log("actual", actual);
        console.log("expected", expected);
        console.log(
            "OZ Base64",
            Base64.encode(bytes(string(abi.encodePacked(svg))))
        );
        //Assert
        assert(
            keccak256(abi.encodePacked(expected)) ==
                keccak256(abi.encodePacked(actual))
        );
    }
}
