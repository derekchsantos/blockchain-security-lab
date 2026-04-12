## 🛠️ O que foi implementado
1. **VulnerableVault.sol:** Um contrato de cofre que continha uma vulnerabilidade de **Reentrancy**.
2. **Correção de Segurança:** Implementação do padrão *Checks-Effects-Interactions*.
3. **Fuzz Testing:** Testes unitários com valores aleatórios (256 runs) para garantir a integridade das funções isoladas.
4. **Stateful Invariant Testing:** Testes de estado avançados para garantir que a contabilidade do contrato nunca falhe, independente da sequência de transações.

## 🧪 Demonstração de Testes de Estresse (Foundry Invariants)
O motor de testes do Foundry foi configurado para tentar "quebrar" o contrato através de milhares de combinações de depósitos e saques aleatórios.

![Resultado do Teste de Invariante]<img width="849" height="301" alt="image" src="https://github.com/user-attachments/assets/4e79ced5-2907-4d7a-89bc-68ab3d0d7c70" />


**Métricas do Teste:**
- **Chamadas Totais:** 128.000 interações automáticas.
- **Cenários (Runs):** 256 sequências distintas.
- **Resultado:** 100% de sucesso. A invariante de saldo foi mantida em todos os estados.

## 🛡️ Segurança (CI/CD)
O projeto conta com um workflow do GitHub Actions que roda o **Slither** automaticamente a cada push. Isso garante um nível de auditoria contínua no ciclo de desenvolvimento.

