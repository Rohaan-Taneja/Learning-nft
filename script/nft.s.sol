// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";

import {nft} from "../src/nft.sol";

contract deployBasicNFT is Script {
    function run() external returns (nft) {
        vm.startBroadcast();
        nft basicNFT = new nft();
        vm.stopBroadcast();
        return basicNFT;
    }
}
