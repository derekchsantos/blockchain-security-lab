// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VulnerableVault.sol";

contract VulnerableVaultTest is Test {
    VulnerableVault public vault;

    function setUp() public {
        vault = new VulnerableVault();
    }

    function testFuzz_Withdraw(uint256 amount) public {
        vm.assume(amount > 0 && amount < 100 ether);
        
        vm.deal(address(this), amount);
        vault.deposit{value: amount}();

        vault.withdrawAll();

        assertEq(vault.balances(address(this)), 0);
        assertEq(address(vault).balance, 0);
    }
        receive() external payable {}
}
