//SPDX-Lcense-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    constructor() ERC721("Dogie", "DOG") {}
}
