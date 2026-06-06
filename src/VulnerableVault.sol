// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableVault {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawAll() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Saldo insuficiente");
        
        // CORRECAO: Atualizar o saldo ANTES de enviar o dinheiro
        balances[msg.sender] = 0;
        
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transferencia falhou");
    }
}

