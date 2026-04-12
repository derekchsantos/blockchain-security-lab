# Blockchain Security Lab 🛡️

Este repositório contém estudos avançados de segurança em Smart Contracts (Solidity), utilizando ferramentas de elite do ecossistema Web3.

## 🚀 Tecnologias e Ferramentas
- **Foundry:** Framework de testes de alta performance (Property-based Testing & Fuzzing).
- **Slither:** Analisador estático para detecção de vulnerabilidades críticas.
- **GitHub Actions:** Pipeline de CI/CD para auditoria automática de segurança a cada commit.
- **WSL2/Ubuntu:** Ambiente de desenvolvimento Linux otimizado.

## 🛠️ O que foi implementado
1. **VulnerableVault.sol:** Um contrato de cofre que continha uma vulnerabilidade de **Reentrancy**.
2. **Correção de Segurança:** Implementação do padrão *Checks-Effects-Interactions*.
3. **Fuzz Testing:** Testes unitários com valores aleatórios (256 runs) para garantir a integridade do contrato.
4. **Invariant Testing:** (Em progresso) Testes de estado para garantir que a contabilidade do contrato nunca falhe.

## 🛡️ Segurança (CI/CD)
O projeto conta com um workflow do GitHub Actions que roda o **Slither** automaticamente. Isso garante que nenhum código com vulnerabilidades conhecidas seja aceito no repositório.

## 📋 Como rodar os testes
```bash
# Rodar testes unitários e fuzzing
forge test

# Rodar análise de segurança
slither . --compile-force-framework foundry

