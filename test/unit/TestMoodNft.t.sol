//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNftTest is Test {
    address USER = makeAddr("user");

    MoodNft moodNft;

    string public constant BASE_URI = "data:application/json;base64,";

    string public constant SAD_SVG_URI =
        "data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJDYXBhXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIKICAgIHk9IjBweCIgdmlld0JveD0iMCAwIDQ5MCA0OTAiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDQ5MCA0OTA7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4KICAgIDxnPgogICAgICAgIDxwYXRoIGQ9Ik0xMTkuMzksMzQwLjAxNWwxOC4zMzMsMjQuNTM5YzQuNDExLTMuMjYsMTA4Ljc3My03OC45MSwyMTQuNTg0LDBMMzcwLjYxLDM0MAoJCUMyNDYuMjExLDI0Ny4xODMsMTIwLjY0NiwzMzkuMDg4LDExOS4zOSwzNDAuMDE1eiIgLz4KICAgICAgICA8cGF0aCBkPSJNMTU5Ljc0NCwyMzYuMDk2YzIzLjU1LDAsNDIuNjQyLTE5LjA5Miw0Mi42NDItNDIuNjQyYzAtMTAuNDYxLTMuOTEzLTE5LjkxNS0xMC4xNjQtMjcuMzM0aDI5LjQwNXYtMzAuNjI1SDk3Ljg1NnYzMC42MjUKCQloMjkuNDA5Yy02LjI1MSw3LjQxOS0xMC4xNjQsMTYuODczLTEwLjE2NCwyNy4zMzRDMTE3LjEwMiwyMTcuMDA0LDEzNi4xOTQsMjM2LjA5NiwxNTkuNzQ0LDIzNi4wOTZ6IiAvPgogICAgICAgIDxwYXRoIGQ9Ik0yNjguMzcyLDE2Ni4xMmgzMS41MDRjLTYuMjUxLDcuNDE5LTEwLjE2NCwxNi44NzMtMTAuMTY0LDI3LjMzNGMwLDIzLjU1LDE5LjA5MSw0Mi42NDIsNDIuNjQyLDQyLjY0MgoJCWMyMy41NSwwLDQyLjY0MS0xOS4wOTIsNDIuNjQxLTQyLjY0MmMwLTEwLjQ2MS0zLjkxMy0xOS45MTUtMTAuMTY0LTI3LjMzNGgyNy4zMjd2LTMwLjYyNUgyNjguMzcyVjE2Ni4xMnoiIC8+CiAgICAgICAgPHBhdGggZD0iTTQyMC45MTQsMEg2OS4wODZDMzAuOTk5LDAsMCwzMC45OTksMCw2OS4wODZ2MzUxLjgyOUMwLDQ1OS4wMDEsMzAuOTk5LDQ5MCw2OS4wODYsNDkwaDM1MS44MjkKCQlDNDU5LjAwMSw0OTAsNDkwLDQ1OS4wMDEsNDkwLDQyMC45MTRWNjkuMDg2QzQ5MCwzMC45OTksNDU5LjAwMSwwLDQyMC45MTQsMHogTTQ1OS4zNzUsNDIwLjkxNAoJCWMwLDIxLjIwNC0xNy4yNTcsMzguNDYxLTM4LjQ2MSwzOC40NjFINjkuMDg2Yy0yMS4yMDQsMC0zOC40NjEtMTcuMjU3LTM4LjQ2MS0zOC40NjFWNjkuMDg2YzAtMjEuMjA0LDE3LjI1Ni0zOC40NjEsMzguNDYxLTM4LjQ2MQoJCWgzNTEuODI5YzIxLjIwNCwwLDM4LjQ2MSwxNy4yNTcsMzguNDYxLDM4LjQ2MVY0MjAuOTE0eiIgLz4KICAgIDwvZz4KPC9zdmc+";

    string public constant HAPPY_SVG_URI =
        "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAwcHgiIGhlaWdodD0iODAwcHgiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxwYXRoCiAgICAgICAgZD0iTTE1IDIyLjc1SDlDMy41NyAyMi43NSAxLjI1IDIwLjQzIDEuMjUgMTVWOUMxLjI1IDMuNTcgMy41NyAxLjI1IDkgMS4yNUgxNUMyMC40MyAxLjI1IDIyLjc1IDMuNTcgMjIuNzUgOVYxNUMyMi43NSAyMC40MyAyMC40MyAyMi43NSAxNSAyMi43NVpNOSAyLjc1QzQuMzkgMi43NSAyLjc1IDQuMzkgMi43NSA5VjE1QzIuNzUgMTkuNjEgNC4zOSAyMS4yNSA5IDIxLjI1SDE1QzE5LjYxIDIxLjI1IDIxLjI1IDE5LjYxIDIxLjI1IDE1VjlDMjEuMjUgNC4zOSAxOS42MSAyLjc1IDE1IDIuNzVIOVoiCiAgICAgICAgZmlsbD0iIzAwMDAwMCIgLz4KICAgIDxwYXRoCiAgICAgICAgZD0iTTE1LjUgMTAuNUMxNC4yNiAxMC41IDEzLjI1IDkuNDkgMTMuMjUgOC4yNUMxMy4yNSA3LjAxIDE0LjI2IDYgMTUuNSA2QzE2Ljc0IDYgMTcuNzUgNy4wMSAxNy43NSA4LjI1QzE3Ljc1IDkuNDkgMTYuNzQgMTAuNSAxNS41IDEwLjVaTTE1LjUgNy41QzE1LjA5IDcuNSAxNC43NSA3Ljg0IDE0Ljc1IDguMjVDMTQuNzUgOC42NiAxNS4wOSA5IDE1LjUgOUMxNS45MSA5IDE2LjI1IDguNjYgMTYuMjUgOC4yNUMxNi4yNSA3Ljg0IDE1LjkxIDcuNSAxNS41IDcuNVoiCiAgICAgICAgZmlsbD0iIzAwMDAwMCIgLz4KICAgIDxwYXRoCiAgICAgICAgZD0iTTguNSAxMC41QzcuMjYgMTAuNSA2LjI1IDkuNDkgNi4yNSA4LjI1QzYuMjUgNy4wMSA3LjI2IDYgOC41IDZDOS43NCA2IDEwLjc1IDcuMDEgMTAuNzUgOC4yNUMxMC43NSA5LjQ5IDkuNzQgMTAuNSA4LjUgMTAuNVpNOC41IDcuNUM4LjA5IDcuNSA3Ljc1IDcuODQgNy43NSA4LjI1QzcuNzUgOC42NiA4LjA5IDkgOC41IDlDOC45MSA5IDkuMjUgOC42NiA5LjI1IDguMjVDOS4yNSA3Ljg0IDguOTEgNy41IDguNSA3LjVaIgogICAgICAgIGZpbGw9IiMwMDAwMDAiIC8+CiAgICA8cGF0aAogICAgICAgIGQ9Ik0xMiAxOS40NUM5LjEgMTkuNDUgNi43NSAxNy4wOSA2Ljc1IDE0LjJDNi43NSAxMy4yOSA3LjQ5IDEyLjU1IDguNCAxMi41NUgxNS42QzE2LjUxIDEyLjU1IDE3LjI1IDEzLjI5IDE3LjI1IDE0LjJDMTcuMjUgMTcuMDkgMTQuOSAxOS40NSAxMiAxOS40NVpNOC40IDE0LjA1QzguMzIgMTQuMDUgOC4yNSAxNC4xMiA4LjI1IDE0LjJDOC4yNSAxNi4yNyA5LjkzIDE3Ljk1IDEyIDE3Ljk1QzE0LjA3IDE3Ljk1IDE1Ljc1IDE2LjI3IDE1Ljc1IDE0LjJDMTUuNzUgMTQuMTIgMTUuNjggMTQuMDUgMTUuNiAxNC4wNUg4LjRWMTQuMDVaIgogICAgICAgIGZpbGw9IiMwMDAwMDAiIC8+Cjwvc3ZnPg==";

    function setUp() public {
        moodNft = new MoodNft(SAD_SVG_URI, HAPPY_SVG_URI);
    }

    function testViewTokenUri() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));

        assert(
            keccak256(abi.encodePacked(moodNft.tokenURI(0))) ==
                keccak256(
                    abi.encodePacked(
                        BASE_URI,
                        Base64.encode(
                            bytes(
                                abi.encodePacked(
                                    '{"name": "',
                                    moodNft.name(),
                                    '", "description": An NFT that reflects the owners mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "',
                                    HAPPY_SVG_URI,
                                    '"}'
                                )
                            )
                        )
                    )
                )
        );
    }
}