# Estratégia de Branching Semântica — Labirinto com Grafos

Documento que define como organizar branches, commits e pull requests neste projeto.

---

## 🌳 Estrutura de Branches

```
main (produção — sempre estável)
 ↑
develop (integração — testes passam)
 ↑
feature/* (tarefas do projeto)
test/*    (testes e validação)
docs/*    (documentação)
fix/*     (correções de bugs)
```

### Branch Main
- **Propósito:** Código pronto para apresentação/entrega.
- **Quem faz merge:** Apenas PRs da `develop` após review.
- **Regra:** Sempre compilável e todos os testes passam.

### Branch Develop
- **Propósito:** Integração de features em desenvolvimento.
- **Quem faz merge:** Features acabadas vêm de branches temáticas.
- **Regra:** Testes devem passar antes de merge.

### Branches Temáticas
Nomenclatura: `[tipo]/[descrição-em-kebab-case]`

| Tipo | Prefixo | Exemplo | Quando usar |
|------|---------|---------|-------------|
| Feature | `feature/` | `feature/bfs-algorithm` | Nova funcionalidade |
| Teste | `test/` | `test/unit-tests-bfs` | Testes automatizados |
| Documentação | `docs/` | `docs/entrega-document` | Docs e explicações |
| Bugfix | `fix/` | `fix/audio-threading` | Correção de bugs |
| Refatoração | `refactor/` | `refactor/code-cleanup` | Limpeza/reorganização |

---

## 📝 Commits Semânticos (Conventional Commits)

### Formato

```
<tipo>(<escopo>): <descrição>

<corpo>

<rodapé>
```

### Tipos

- **feat**: Nova funcionalidade
- **fix**: Correção de bug
- **docs**: Alterações em documentação
- **test**: Adição/alteração de testes
- **refactor**: Refatoração sem mudança funcional
- **style**: Formatação (indentação, nomes, etc.)
- **chore**: Tarefas auxiliares (build, deps, etc.)

### Escopos

- `core`: Núcleo (labirinto.c, labirinto.h)
- `algo`: Algoritmos (BFS, Dijkstra)
- `viz`: Visualização e áudio
- `test`: Testes
- `docs`: Documentação
- `build`: Build e CI

### Exemplos

```
feat(core): implementa struct Posicao e Labirinto
test(algo): adiciona 8 testes para BFS e Dijkstra
docs(entrega): preenche documento com nomes dos integrantes
fix(viz): corrige audio picotado em animação
refactor(core): reorganiza código de labirinto.c
```

---

## 🔗 Issues

### Nomenclatura

`[Tipo] Descrição da Tarefa`

### Tipos

- `[Feat]` - Nova funcionalidade
- `[Fix]` - Correção de bug
- `[Docs]` - Documentação
- `[Test]` - Testes

### Exemplo

```
[Feat] Implementar algoritmo BFS para encontrar menor caminho
[Docs] Preencher documento de entrega com nomes dos integrantes
[Test] Criar testes unitários para o Dijkstra
```

---

## 🔄 Fluxo Completo: Issue → Branch → Commit → PR

### Passo 1: Criar a Issue

```bash
gh issue create \
  --title "[Feat] Implementar BFS" \
  --body "Criar a função resolverLabirinto() com busca em largura para encontrar o menor caminho no labirinto." \
  --label "feature"
```

Outputs: `Issue #1 created` (anote o número).

### Passo 2: Criar a Branch Semântica

```bash
git checkout develop
git pull origin develop
git checkout -b feature/bfs-algorithm
```

### Passo 3: Editar código e fazer commits semânticos

```bash
# Edite os arquivos (ex: labirinto.c, labirinto.h)

# Stage os arquivos
git add labirinto.c labirinto.h

# Commit com mensagem semântica
git commit -m "feat(core): implementa funcao resolverLabirinto() com BFS"

# Se tiver múltiplos commits:
git add testes.c
git commit -m "test(algo): adiciona 6 testes para validar BFS"
```

### Passo 4: Push da Branch

```bash
git push -u origin feature/bfs-algorithm
```

### Passo 5: Criar Pull Request

```bash
gh pr create \
  --base develop \
  --head feature/bfs-algorithm \
  --title "feat(core): implementa busca em largura (BFS)" \
  --body "Closes #1

## Contexto
Implementei o algoritmo de busca em largura (BFS) para encontrar o menor caminho do labirinto representado como grafo.

## Arquivos alterados
- labirinto.c (adicionado resolverLabirinto)
- labirinto.h (assinatura de função)
- testes.c (6 testes novos)

## Como testar
1. \`gcc -ansi -pedantic -Wall labirinto.c testes.c -o testes.exe\`
2. \`testes.exe\` (deve passar todos os testes)

## Checklist
- [x] Compila sem avisos
- [x] Todos os testes passam
- [x] Comentários explicam o porquê
- [x] Nomenclatura em português
"
```

### Passo 6: Review e Merge

```bash
# Revisar no GitHub (abrir link do PR)
# Depois de aprovado, mergear:
gh pr merge [numero-do-pr] --merge --delete-branch
```

---

## 📋 Lista de Tarefas (Issues + Branches)

### Núcleo (Implementação)

| # | Tarefa | Tipo | Branch | Status |
|---|--------|------|--------|--------|
| 1 | Estruturas (Posicao, Labirinto, Resultado) | feat | `feature/core-structures` | 🔄 |
| 2 | Funções auxiliares (carregar, exibir, localizar) | feat | `feature/core-helpers` | 🔄 |
| 3 | BFS (Busca em Largura) | feat | `feature/bfs-algorithm` | 🔄 |
| 4 | Dijkstra | feat | `feature/dijkstra-algorithm` | 🔄 |
| 5 | Visualização e Animação | feat | `feature/visualization` | 🔄 |
| 6 | Áudio com Threads | feat | `feature/audio-threading` | 🔄 |
| 7 | Menu Principal | feat | `feature/main-menu` | 🔄 |

### Testes

| # | Tarefa | Tipo | Branch | Status |
|---|--------|------|--------|--------|
| 8 | Testes BFS | test | `test/bfs-tests` | 🔄 |
| 9 | Testes Dijkstra | test | `test/dijkstra-tests` | 🔄 |
| 10 | Testes de Integração | test | `test/integration-tests` | 🔄 |

### Documentação

| # | Tarefa | Tipo | Branch | Status |
|---|--------|------|--------|--------|
| 11 | Documento de Entrega | docs | `docs/entrega-document` | 🔄 |
| 12 | Capturas de Tela | docs | `docs/screenshots` | 🔄 |
| 13 | Guia de Apresentação | docs | `docs/presentation-guide` | 🔄 |

---

## 🎯 Labels no GitHub

Use estas labels para categorizar issues:

- `feature` — Nova funcionalidade
- `bug` — Correção de erro
- `documentation` — Docs
- `test` — Testes
- `ready` — Pronta para começar
- `in-progress` — Em desenvolvimento
- `review` — Aguardando revisão
- `urgent` — Precisa fazer antes da data de entrega (25/06/2026)

---

## 💡 Dicas

1. **Commits pequenos:** Um commit = uma mudança lógica. Não junte várias features num só commit.
2. **Mensagens descritivas:** `git commit -m "foo"` é ruim. `git commit -m "feat(core): implementa reconstrucao de caminho"` é bom.
3. **Sempre da develop:** Nunca crie feature diretamente da `main`.
4. **PR antes de merge:** Sempre abra um PR, mesmo que seja você mesmo fazendo review.
5. **Squash se necessário:** Se uma feature tiver muitos commits pequenos, faça `git rebase -i` antes do PR.

---

## 🔗 Referências

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Git Flow](https://datasift.github.io/gitflow/IntroducingGitFlow.html)
- [GitHub PR Template](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests)
