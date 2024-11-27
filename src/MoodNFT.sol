// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    error MoodNFT_cantFlipMoodIfNotOwner();

    enum Mood {
        Happy,
        Sad
    }

    uint256 public s_tokenCounter;
    string public s_happySvgImageUri;
    string public s_sadSvgImageUri;

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory happySvgImageUri, string memory sadSvgImageUri) ERC721("MoodNFT", "MN") {
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.Happy;
        s_tokenCounter++;
    }

    function flipmood(uint256 tokenId) public {
        //msg.sender is neither owner not spender
        if (!_isAuthorized(_ownerOf(tokenId), msg.sender, tokenId)) {
            revert MoodNFT_cantFlipMoodIfNotOwner();
        }

        if (s_tokenIdToMood[tokenId] == Mood.Happy) {
            s_tokenIdToMood[tokenId] = Mood.Sad;
        } else {
            s_tokenIdToMood[tokenId] = Mood.Happy;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.Happy) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(), // You can add whatever name here
                            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
