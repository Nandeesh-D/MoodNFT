// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract MintBasicNFT is Script {
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        vm.startBroadcast();
        // address mostRecentlyDeployed=DevOpsTools.get_most_recent_deployment("BasicNFT", block.chainid);
        mintNFTOnContract(0x06b43fAc165b44406C70aB35Fb6c0c0eEa1Bd77f);
        vm.stopBroadcast();
    }

    function mintNFTOnContract(address contractAddress) public {
        BasicNFT(contractAddress).mintNFT(PUG);
    }
}
