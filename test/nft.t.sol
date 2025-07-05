// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "../lib/forge-std/src/Test.sol";

import {nft} from "../src/nft.sol";

import {deployBasicNFT} from "../script/nft.s.sol";

contract nftTesting is Test {
    nft public basicNFT;
    deployBasicNFT public deploy_nft;
    address user = address(1);
    

    function setUp() public {
        deploy_nft = new deployBasicNFT();
        basicNFT = deploy_nft.run();
    }

    function test_token_name() public {
        string memory expectedName = basicNFT.name();

        string memory given_name = "ROHAAN_NFT";

        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(given_name))
        );
    }

    function test_minting() public {
        vm.prank(user);
        string memory token_URI = "ipfs://QmPkEpcJio7TQLauDduKfAnkrXFFJ17TAsfr4R6GeCB2d7";
        basicNFT._mintNFT(token_URI);
        assert(basicNFT.ownerOf(0) == user);
        assert(basicNFT.balanceOf(user)==1);
    }
}
