// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.11;
pragma experimental ABIEncoderV2;

import "./Deploy2/HederaTokenService.sol";
import "./Deploy2/HederaResponseCodes.sol";


contract MintAssoTransHTS is HederaTokenService {
    address tokenAddress;

    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
    }

    function mintFungibleToken(int64 _amount) external {
    bytes[] memory metadata = new bytes[](0); // Empty metadata
    (int response, uint64 newTotalSupply, int64[] memory serialNumbers) = HederaTokenService.mintToken(tokenAddress, uint64(_amount), metadata);
    if (response != HederaResponseCodes.SUCCESS) { 
        revert ("Mint Failed");
    }
}



    function tokenAssociate(address _account) external {
        int response = HederaTokenService.associateToken(_account, tokenAddress);
        if (response != HederaResponseCodes.SUCCESS) {
            revert("Associate Failed");
        }
    }

    function tokenTransfer(address _sender, address _receiver, int64 _amount) external {
        int response = HederaTokenService.transferToken(tokenAddress, _sender, _receiver, _amount);
        if (response != HederaResponseCodes.SUCCESS) {
            revert("Transfer Failed");
        }
    }
}
