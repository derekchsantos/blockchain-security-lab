// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VulnerableVault.sol";

//@author Derek Christopher

contract Handler is Test {
    VulnerableVault public vault;
    uint256 public totalDeposited;

    constructor(VulnerableVault _vault) {
        vault = _vault;
    }

    function deposit(uint256 amount) public {
        amount = bound(amount, 1, address(this).balance);
        vault.deposit{value: amount}();
        totalDeposited += amount;
    }

    function withdraw() public {
        if (totalDeposited > 0) {
            vault.withdrawAll();
            totalDeposited = 0;
        }
    }

    receive() external payable {}
}
