// SPDX-License-Identifier:MIt
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    function run() external returns (MoodNFT) {
        string memory happySvg = vm.readFile("./img/happy.svg");
        string memory sadSvg = vm.readFile("./img/sad.svg");

        //deploying the moodNFT
        vm.startBroadcast();
        console.log("deployer:", msg.sender);
        console.log("deployer:", tx.origin);
        console.log(block.chainid);
        MoodNFT moodNFt = new MoodNFT(svgToImageUri(happySvg), svgToImageUri(sadSvg));
        vm.stopBroadcast();
        return moodNFt;
    }

    function svgToImageUri(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
