# Blockchain Security & Engineering Lab 🛡️⚙️

Este repositório contém estudos avançados de segurança e engenharia em Smart Contracts (Solidity), utilizando ferramentas de elite do ecossistema Web3 para garantir contratos escaláveis e resilientes.

## 🚀 Tecnologias e Ferramentas
- **Foundry:** Framework de testes de alta performance (Property-based Testing, Fuzzing & Invariants).
- **Slither:** Analisador estático para detecção de vulnerabilidades críticas.
- **GitHub Actions:** Pipeline de CI/CD para auditoria automática de segurança a cada commit.
- **WSL2/Ubuntu:** Ambiente de desenvolvimento Linux otimizado.

## 🛠️ Segurança & Auditoria
1. **VulnerableVault.sol:** Desenvolvimento de um cofre com vulnerabilidade de **Reentrancy**.
2. **Correção de Segurança:** Implementação do padrão *Checks-Effects-Interactions* para mitigação de ataques.
3. **Fuzz Testing:** Testes unitários com valores aleatórios (256 runs) para validar funções isoladas.
4. **Stateful Invariant Testing:** Testes de estado para garantir a integridade contábil do contrato.

### 🧪 Demonstração de Testes de Estresse (Foundry Invariants)
O motor de testes do Foundry foi configurado para tentar "quebrar" o contrato através de milhares de combinações aleatórias.

<img width="796" height="303" alt="image" src="https://github.com/user-attachments/assets/44c77f2a-a809-49bc-923b-b2b98e87b761" />

**Métricas alcançadas:**
- **Chamadas Totais:** 128.000 interações automáticas.
- **Cenários (Runs):** 256 sequências distintas.
- **Resultado:** 100% de sucesso.

## 🧠 Engenharia de Blockchain & Criptografia
Além da segurança, o laboratório foca em infraestrutura e otimização:

1. **ECDSA Verification (`CryptoVerify.sol`):** 
   - Verificação de assinaturas digitais (r, s, v) off-chain.
   - Uso de **Assembly (Yul)** para manipulação eficiente de memória e extração de componentes de assinatura.
   - Validação via Fuzzing respeitando os limites matemáticos da curva **Secp256k1**.
<img width="818" height="152" alt="image" src="https://github.com/user-attachments/assets/cdc642d6-fe4c-4583-8d0c-1f4248c34a2e" />

   
2. **Merkle Trees (`MerkleVerifier.sol`):**
   - Implementação de verificação de provas Merkle para Whitelists e Airdrops.
   - Foco em **gas optimization**, permitindo validar listas massivas de usuários com custo computacional mínimo na rede.
   

   <img width="826" height="154" alt="image" src="https://github.com/user-attachments/assets/f9b16469-ce39-4142-9349-14a07c47caf0" />


## 🛡️ Pipeline de Segurança (CI/CD)
O projeto utiliza **GitHub Actions** para rodar o **Slither** automaticamente a cada push, impedindo que códigos com vulnerabilidades conhecidas sejam integrados ao branch principal.

## 📋 Como rodar os testes
```bash
# Rodar todos os testes (Unitários, Fuzzing e Invariantes)
forge test

# Rodar análise de segurança estática
slither . --compile-force-framework foundry

