// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {stdJson} from "forge-std/StdJson.sol";

contract MintBasicNft is Script {
    string public constant SHIBA_INU_URI =
        "ipfs://bafybeib5ff6jvltcgyct2c225vfdobpmogfm4rb6ykjp3g75bklbdfiqne/?filename=test.json";

    function getDeployedContractAddress() private view returns (address) {
        string memory path = string.concat(
            vm.projectRoot(), "/broadcast/DeployBasicNft.s.sol/", Strings.toString(block.chainid), "/run-latest.json"
        );
        string memory json = vm.readFile(path);
        bytes memory contractAddress = stdJson.parseRaw(json, ".transactions[0].contractAddress");
        return (bytesToAddress(contractAddress));
    }

    function bytesToAddress(bytes memory bys) private pure returns (address addr) {
        assembly {
            addr := mload(add(bys, 32))
        }
    }

    function run() external {
        address mostRecentlyDeployed = getDeployedContractAddress();
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(SHIBA_INU_URI);
        vm.stopBroadcast();
    }
}



contract MintMoodNft is Script {
    function getDeployedContractAddress() private view returns (address) {
        string memory path = string.concat(
            vm.projectRoot(), "/broadcast/DeployMoodNft.s.sol/", Strings.toString(block.chainid), "/run-latest.json"
        );
        string memory json = vm.readFile(path);
        bytes memory contractAddress = stdJson.parseRaw(json, ".transactions[0].contractAddress");
        return (bytesToAddress(contractAddress));
    }

    function bytesToAddress(bytes memory bys) private pure returns (address addr) {
        assembly {
            addr := mload(add(bys, 32))
        }
    }

    function run() external {
        address mostRecentlyDeployed = getDeployedContractAddress();
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNft(contractAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    function getDeployedContractAddress() private view returns (address) {
        string memory path = string.concat(
            vm.projectRoot(), "/broadcast/DeployMoodNft.s.sol/", Strings.toString(block.chainid), "/run-latest.json"
        );
        string memory json = vm.readFile(path);
        bytes memory contractAddress = stdJson.parseRaw(json, ".transactions[0].contractAddress");
        return (bytesToAddress(contractAddress));
    }

    function bytesToAddress(bytes memory bys) private pure returns (address addr) {
        assembly {
            addr := mload(add(bys, 32))
        }
    }

    function run() external {
        address mostRecentlyDeployed = getDeployedContractAddress();
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNft(contractAddress).flipMood(0);
        vm.stopBroadcast();
    }
}