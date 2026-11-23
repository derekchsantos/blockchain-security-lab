// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VulnerableVault.sol";
import "./Handler.sol";

contract VaultInvariants is Test {
    VulnerableVault public vault;
    Handler public handler;

    function setUp() public {
        vault = new VulnerableVault();
        handler = new Handler(vault);

        vm.deal(address(handler), 100 ether);

        targetContract(address(handler));
    }

    function invariant_VaultBalanceMatchesLogic() public view {
        assertEq(address(vault).balance, handler.totalDeposited());
    }
}

