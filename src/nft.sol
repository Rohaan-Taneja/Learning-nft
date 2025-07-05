// SPDX-License-Identifier: MIT


pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract nft is ERC721{

    uint256 private tokenId;

    mapping(uint256 => string) public tokenId_to_Uri; 

    // this will create a collection of nft's
    // each nft in this this collection is unique ,can have different images , prices etc
    constructor() ERC721("ROHAAN_NFT" , "$"){
        tokenId =0;

    }


    function _mintNFT(string memory _tokenUri)  public {
        tokenId_to_Uri[tokenId]= _tokenUri;
        _safeMint( msg.sender , tokenId);
        tokenId++;
    }

    //  a function in which we give nft token id and it returns that nft token details 
    // like image url , name , etc in json format
    function tokenURI (uint256 _tokenId) public view override returns(string memory){
        return tokenId_to_Uri[_tokenId];

    }

}