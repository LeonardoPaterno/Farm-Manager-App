
# Blueprint: Farm Manager App

## Visão Geral do Projeto

O **Farm Manager App** é um aplicativo móvel construído com Flutter, projetado para auxiliar no gerenciamento completo de uma fazenda de gado leiteiro. O objetivo é fornecer uma ferramenta intuitiva e poderosa para rastrear a produção de leite, o ciclo de reprodução, a saúde do rebanho, as finanças e o inventário.

## Recursos Planejados

*   **Autenticação de Usuário:** Login seguro utilizando Firebase Authentication.
*   **Dashboard Principal:** Uma visão geral com estatísticas chave, alertas e acesso rápido aos módulos.
*   **Gerenciamento de Produção de Leite:** Registro diário da produção, com relatórios e gráficos de desempenho.
*   **Gerenciamento de Reprodução:** Acompanhamento do ciclo de cio, inseminações e previsões de parto.
*   **Gerenciamento de Saúde:** Registro de vacinas, tratamentos e histórico de saúde dos animais.
*   **Gerenciamento Financeiro:** Controle de despesas e receitas, com relatórios de fluxo de caixa.
*   **Gerenciamento de Inventário:** Rastreamento de insumos, ração, medicamentos, etc.
*   **Suporte a Múltiplos Idiomas:** Interface disponível em Português e Inglês.

---

## Plano de Desenvolvimento Atual: Fase 1 - Fundação

**Objetivo:** Configurar a estrutura essencial do projeto, incluindo dependências, navegação, tema e internacionalização.

**Passos:**

1.  [X] Inicializar o repositório Git e o projeto Flutter.
2.  [ ] Criar o arquivo `blueprint.md` para documentação do projeto.
3.  [ ] Adicionar dependências essenciais (`provider`, `go_router`, `firebase_core`, `firebase_auth`, `intl`, `google_fonts`, `fl_chart`).
4.  [ ] Configurar a estrutura de internacionalização (l10n) para Português e Inglês.
5.  [ ] Implementar um sistema de tema customizável (Material 3) com suporte a modo claro/escuro.
6.  [ ] Estruturar o roteamento básico com `go_router` (ex: tela de login, tela principal).
7.  [ ] Criar um commit com a fundação do projeto configurada.
