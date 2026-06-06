// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/CryptoVerify.sol";

contract CryptoVerifyTest is Test {
    CryptoVerify public verifier;
    
    // Chave privada para o teste
    uint256 internal ownerPrivateKey = 0xA11CE;
    address internal owner;

    function setUp() public {
        verifier = new CryptoVerify();
        owner = vm.addr(ownerPrivateKey);
    }

    function test_SignatureVerification() public view {
        string memory message = "Ola, Blockchain Engineer!";
        
        bytes32 messageHash = verifier.getMessageHash(message);
        bytes32 ethSignedMessageHash = verifier.getEthSignedMessageHash(messageHash);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, ethSignedMessageHash);
        bytes memory signature = abi.encodePacked(r, s, v);

        bool isValid = verifier.verify(owner, message, signature);

        assertTrue(isValid, "A assinatura deveria ser valida");
    }

    function testFuzz_SignatureFailsForWrongSigner(uint256 fakeKey) public view {
        // CORREÇÃO DE ENGENHARIA:
        // Restringe a chave para o intervalo válido da curva Secp256k1 do Ethereum
        // O valor abaixo é o "n" (order) da curva.
        uint256 secp256k1Order = 0xffffffffffffffffffffffffffffffffbaaedce6af48a03bbfd25e8cd0364141;
        
        vm.assume(fakeKey > 0 && fakeKey < secp256k1Order);
        vm.assume(fakeKey != ownerPrivateKey);
        
        string memory message = "Mensagem Secreta";
        bytes32 hash = verifier.getEthSignedMessageHash(verifier.getMessageHash(message));
        
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(fakeKey, hash);
        bytes memory signature = abi.encodePacked(r, s, v);

        bool isValid = verifier.verify(owner, message, signature);
        assertFalse(isValid, "A assinatura deveria ser invalida");
    }
}

