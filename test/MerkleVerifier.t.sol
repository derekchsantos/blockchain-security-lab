// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MerkleVerifier.sol";

contract MerkleVerifierTest is Test {
    MerkleVerifier public verifier;

    bytes32[] public leaves;

    function setUp() public {
        leaves.push(keccak256(abi.encodePacked(address(0x1))));
        leaves.push(keccak256(abi.encodePacked(address(0x2))));
        leaves.push(keccak256(abi.encodePacked(address(0x3))));
        leaves.push(keccak256(abi.encodePacked(address(0x4))));

        bytes32 hash12 = _hashPair(leaves[0], leaves[1]);
        bytes32 hash34 = _hashPair(leaves[2], leaves[3]);
        bytes32 root = _hashPair(hash12, hash34);

        verifier = new MerkleVerifier(root);
    }

    function test_VerifyValidProof() public view {

        
        bytes32[] memory proof = new bytes32[](2);
        proof[0] = leaves[1]; // Vizinho direto
        proof[1] = _hashPair(leaves[2], leaves[3]); 
        bool isValid = verifier.verify(proof, leaves[0]);
        assertTrue(isValid, "A prova Merkle deveria ser valida");
    }

    function test_FailInvalidProof() public view {
        bytes32[] memory proof = new bytes32[](2);
        proof[0] = leaves[1];
        proof[1] = leaves[2]; // Prova errada

        bool isValid = verifier.verify(proof, leaves[0]);
        assertFalse(isValid, "A prova Merkle deveria ser invalida");
    }

    function _hashPair(bytes32 a, bytes32 b) internal pure returns (bytes32) {
        return a <= b ? keccak256(abi.encodePacked(a, b)) : keccak256(abi.encodePacked(b, a));
    }
}
