// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VulnerableVault.sol";
import "./Handler.sol";

// REMOVIDO o "InvariantTest", herde apenas de "Test"
contract VaultInvariants is Test {
    VulnerableVault public vault;
    Handler public handler;

    function setUp() public {
        vault = new VulnerableVault();
        handler = new Handler(vault);

        // Dá 100 ETH para o Handler brincar
        vm.deal(address(handler), 100 ether);

        // Diz ao Foundry para focar as chamadas no Handler
        targetContract(address(handler));
    }

    // O Foundry reconhece que é um teste de invariante pelo prefixo "invariant_"
    function invariant_VaultBalanceMatchesLogic() public view {
        assertEq(address(vault).balance, handler.totalDeposited());
    }
}

