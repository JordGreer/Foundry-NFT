//SPDX-Lcense-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {

    uint256 private s_tokenCounter;



    constructor() ERC721("Dogie", "DOG") {}

    function mintNft() public {

    }

    function tokenURI(uint256 tokenId) public ovverride view returns (string memory) {
        return
    }

}
