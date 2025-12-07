// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

interface IUniswapV2Factory {
    function feeToSetter() external view returns (address);
}

contract DeployFactory is Script {
    function run() external {
        // 1. Setup the deployer's private key
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        // 2. Prepare Constructor Arguments
        // UniswapV2Factory requires one argument: address _feeToSetter
        bytes memory args = abi.encode(deployerAddress);

        // 3. Deploy using deployCode
        // This looks for the artifact produced by 'UniswapV2Factory.sol'
        address factoryAddress = deployCode("UniswapV2Factory.sol", args);

        vm.stopBroadcast();

        // 4. Log the result
        console.log("UniswapV2Factory deployed at:", factoryAddress);
        
        // Optional: Verify it works by casting to an interface
        address feeSetter = IUniswapV2Factory(factoryAddress).feeToSetter();
        console.log("Fee Setter is:", feeSetter);
    }
}