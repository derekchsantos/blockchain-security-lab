// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//@author Derek Christopher

contract CryptoVerify {
    /* 
    A assinatura digital no Ethereum é composta por 3 valores: r, s e v.
    Este contrato verifica se uma mensagem foi realmente assinada por um endereço específico.
    */
    function verify(
        address _signer,
        string memory _message,
        bytes memory _signature
    ) public pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recoverSigner(ethSignedMessageHash, _signature) == _signer;
    }

    function getMessageHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        // O prefixo é necessário para evitar que assinaturas sejam usadas em contextos errados
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash));
    }

    function recoverSigner(bytes32 _ethSignedMessageHash, bytes memory _signature)
        public pure returns (address)
    {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function splitSignature(bytes memory _sig)
        public pure returns (bytes32 r, bytes32 s, uint8 v)
    {
        require(_sig.length == 65, "Assinatura invalida");
        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
    }
}
