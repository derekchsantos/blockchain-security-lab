// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VulnerableVault.sol";

contract VulnerableVaultTest is Test {
    VulnerableVault public vault;

    function setUp() public {
        vault = new VulnerableVault();
    }

    // Teste de Fuzzing: o Foundry vai testar milhares de valores no 'amount'
    function testFuzz_Withdraw(uint256 amount) public {
        // Ignora valores zero e valores maiores que o saldo que daremos ao teste
        vm.assume(amount > 0 && amount < 100 ether);
        
        // Simula o depósito
        vm.deal(address(this), amount);
        vault.deposit{value: amount}();

        // Simula o saque
        vault.withdrawAll();

        // Verifica se o saldo no contrato zerou corretamente
        assertEq(vault.balances(address(this)), 0);
        assertEq(address(vault).balance, 0);
    }
    
    // Fallback necessário para este contrato de teste receber Ether de volta
    receive() external payable {}
}
