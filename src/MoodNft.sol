// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    error MoodNft__CantFlipMoodIfNotOwner();

    uint256 s_tokenConter;
    string s_happySvgImageURI;
    string s_sadSvgImageURI;

    enum NFTState {
        HAPPY,
        SAD
    }

    mapping(uint256 => NFTState) private s_tokenIdoToMood;

    constructor(string memory happySvgImageURI, string memory sadSvgImageURI) ERC721("Mood NFT", "MN") {
        s_tokenConter = 0;
        s_happySvgImageURI = happySvgImageURI;
        s_sadSvgImageURI = sadSvgImageURI;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenConter);
        s_tokenIdoToMood[s_tokenConter] = NFTState.HAPPY;
        s_tokenConter++;
    }

    function flipMood(uint256 tokenId) public {
        if (msg.sender != ownerOf(tokenId)) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }

        if (s_tokenIdoToMood[tokenId] == NFTState.HAPPY) {
            s_tokenIdoToMood[tokenId] = NFTState.SAD;
        } else {
            s_tokenIdoToMood[tokenId] = NFTState.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdoToMood[tokenId] == NFTState.HAPPY) {
            imageURI = s_happySvgImageURI;
        } else {
            imageURI = s_sadSvgImageURI;
        }

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    abi.encodePacked(
                        '{"name": "',
                        name(),
                        '", "description": "A NFT that reflects the owners mood", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "',
                        imageURI,
                        '"}'
                    )
                )
            )
        );
    }
}
