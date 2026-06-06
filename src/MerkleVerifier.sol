// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MerkleVerifier {
    // O Merkle Root é a única coisa que guardamos no contrato
    bytes32 public root;

    constructor(bytes32 _root) {
        root = _root;
    }

    function verify(bytes32[] memory proof, bytes32 leaf) public view returns (bool) {
        bytes32 computedHash = leaf;

        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];

            if (computedHash <= proofElement) {
                // Hash à esquerda
                computedHash = keccak256(abi.encodePacked(computedHash, proofElement));
            } else {
                // Hash à direita
                computedHash = keccak256(abi.encodePacked(proofElement, computedHash));
            }
        }

        return computedHash == root;
    }
}
