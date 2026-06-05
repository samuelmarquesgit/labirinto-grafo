# 🤖 AGENTS PLAN — Arquitetura de Agentes Autônomos

Plano detalhado para criar dois agentes autônomos que trabalhem em conjunto para automação completa do projeto.

---

## 🎯 Visão Geral

### Dois Agentes Especializados

```
┌─────────────────────────────────────────────────────┐
│         CÓDIGO-AGENT (Agente Programador)           │
├─────────────────────────────────────────────────────┤
│ • Escreve código (.c, .h)                           │
│ • Modifica implementação                            │
│ • Cria testes                                       │
│ • Valida lógica                                     │
│                                                     │
│ Input: Especificações/Issues                        │
│ Output: Código modificado + Testes                  │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│         GIT-AGENT (Agente Git Automático)           │
├─────────────────────────────────────────────────────┤
│ • Detecta alterações (git diff)                     │
│ • Cria issues automaticamente                       │
│ • Cria branches semânticas                          │
│ • Faz commits inteligentes                          │
│ • Cria PRs com descrições dinâmicas                 │
│ • Faz merge automático                              │
│                                                     │
│ Input: Arquivos modificados                         │
│ Output: PR pronta para revisar                      │
└─────────────────────────────────────────────────────┘
```

---

## 📋 AGENTE 1: CÓDIGO-AGENT (Programador)

### Responsabilidades

✅ **Entender requisitos**
- Ler GitHub Issues
- Analisar especificações em `specs/`
- Extrair escopo de trabalho

✅ **Implementar código**
- Escrever `.c` e `.h` baseado em padrões do projeto
- Seguir C ANSI (C89) para núcleo
- Manter nomenclatura em português
- Seguir indentação de 4 espaços

✅ **Criar testes**
- Escrever testes em `test/testes.c`
- Usar `assert.h` (C ANSI)
- Validar lógica implementada

✅ **Validar código**
- Compilar com `gcc -ansi -pedantic -Wall`
- Rodar testes com `test/run-tests.bat`
- Garantir que tudo passa

### Como Funciona

```
[Usuário cria Issue] 
    ↓
[CÓDIGO-AGENT lê a issue]
    ↓
[Entende requisitos]
    ↓
[Implementa código em branch local]
    ↓
[Cria testes unitários]
    ↓
[Compila e valida]
    ↓
[Tudo passou? SIM]
    ↓
[Notifica GIT-AGENT para criar PR]
```

### Exemplo de Fluxo

**Issue criada:**
```
[Feat] Implementar BFS para encontrar menor caminho
Descrição: Criar resolverLabirinto() usando Busca em Largura
```

**CÓDIGO-AGENT executa:**
1. Lê issue #6
2. Analisa `specs/design.md` para entender modelo
3. Cria função `resolverLabirinto()` em `labirinto.c`
4. Cria testes em `test/testes.c`
5. Compila: `gcc -ansi -pedantic -Wall ...`
6. Roda testes: `test\run-tests.bat`
7. Valida: "TODOS OS TESTES PASSARAM"
8. Sinaliza para GIT-AGENT

---

## 📋 AGENTE 2: GIT-AGENT (Automação de Git)

### Responsabilidades

✅ **Monitorar alterações**
- Detectar `git diff`
- Identificar novos arquivos
- Analisar tipos de alteração

✅ **Criar issues**
- Gerar issue baseada em padrão semântico
- Adicionar labels (feature, test, docs)
- Linkar com especificações

✅ **Criar branches**
- Gerar nome semântico: `feat/core-xyz`
- Fazer checkout automático
- Garantir que está em `develop`

✅ **Fazer commits**
- Mensagem semântica: `feat(core): descrição`
- Corpo com detalhes das alterações
- Incluir referência à issue: `Closes #N`

✅ **Criar PRs**
- Gerar descrição dinamicamente
- Incluir checklist automático
- Adicionar links às issues
- Listar arquivos alterados
- Mostrar estatísticas (linhas ±)

✅ **Fazer merge**
- Validar que tudo passou
- Fazer merge automático quando aprovado
- Deletar branch após merge

### Como Funciona

```
[CÓDIGO-AGENT termina implementação]
    ↓
[GIT-AGENT detecta git diff]
    ↓
[Analisa arquivos modificados]
    ↓
[Cria issue se necessário]
    ↓
[Cria branch semântica]
    ↓
[Faz commit com mensagem inteligente]
    ↓
[Faz push para origin]
    ↓
[Cria PR com descrição dinâmica]
    ↓
[Aguarda aprovação]
    ↓
[Se aprovado: faz merge automático]
    ↓
[Deleta branch remotamente]
```

### Exemplo de Fluxo

**Detecção de alterações:**
```bash
git diff → labirinto.c (modificado)
git diff → test/testes.c (novo)
```

**GIT-AGENT executa:**
1. Detecta: tipo=feat, escopo=algo
2. Cria branch: `feat/algo-implementa-bfs`
3. Faz commit: `feat(algo): implementa funcao resolverLabirinto`
4. Gera PR com:
   - Descrição automática
   - Checklist
   - Estatísticas (linhas ±)
   - Referência a issues
5. Aguarda approval
6. Faz merge automático

---

## 🔄 Integração Entre Agentes

### Fluxo Completo

```
Usuário cria Issue
    ↓
CÓDIGO-AGENT implementa
    ↓
GIT-AGENT automatiza PR
    ↓
PR pronta para revisar
    ↓
Aprovada?
    ├─ SIM → GIT-AGENT faz merge
    └─ NÃO → CÓDIGO-AGENT refatora (volta ao passo 2)
```

### Comunicação

**CÓDIGO-AGENT → GIT-AGENT:**
- Sinaliza quando código está pronto
- Passa tipo de alteração detectado

**GIT-AGENT → CÓDIGO-AGENT:**
- Informa sobre feedback em PRs
- Solicita correções se necessário

---

## 🛠️ Especificações Técnicas

### CÓDIGO-AGENT

**Linguagem:** Python ou PowerShell  
**Interface:** CLI ou webhook GitHub  
**Acesso:** Clone local do repositório

**Funcionalidades:**
```python
class CodigoAgent:
    def ler_issue(issue_number):
        # Lê issue do GitHub
        pass
    
    def analisar_requisitos(issue):
        # Extrai escopo, tipo, descrição
        pass
    
    def implementar_codigo(requisitos):
        # Escreve .c e .h
        pass
    
    def criar_testes(funcionalidade):
        # Escreve testes
        pass
    
    def validar_compilacao():
        # gcc -ansi -pedantic -Wall
        pass
    
    def sinalizar_pronto():
        # Notifica GIT-AGENT
        pass
```

### GIT-AGENT

**Linguagem:** PowerShell (já temos base: `auto-pr.ps1`)  
**Interface:** CLI  
**Acesso:** Git + GitHub CLI (`gh`)

**Funcionalidades:**
```powershell
class GitAgent {
    DetectarAlteracoes() {
        # git diff
    }
    
    CriarIssue($tipo, $escopo) {
        # gh issue create
    }
    
    CriarBranch($nomeSemantico) {
        # git checkout -b
    }
    
    FazerCommit($mensagemSemantica) {
        # git commit
    }
    
    FazerPush() {
        # git push -u origin
    }
    
    CriarPR($descricaoDinamica) {
        # gh pr create
    }
    
    FazerMerge() {
        # gh pr merge
    }
}
```

---

## 📊 Matriz de Responsabilidades

| Tarefa | CÓDIGO-AGENT | GIT-AGENT |
|--------|-------------|----------|
| Ler issues | ✅ | ❌ |
| Escrever código | ✅ | ❌ |
| Criar testes | ✅ | ❌ |
| Validar compilação | ✅ | ❌ |
| Detectar alterações | ❌ | ✅ |
| Criar branches | ❌ | ✅ |
| Fazer commits | ❌ | ✅ |
| Criar PRs | ❌ | ✅ |
| Fazer merge | ❌ | ✅ |
| Gerenciar issues | ❌ | ✅ |

---

## 🚀 Implementação Progressiva

### Fase 1: GIT-AGENT (Agora/Próximas Semanas)
- ✅ Já temos `auto-pr.ps1` base
- Expandir para criar issues automáticas
- Adicionar validação inteligente
- Integrar com GitHub Webhooks

### Fase 2: CÓDIGO-AGENT (Próximas Semanas/Meses)
- Treinar modelo com padrões do projeto
- Implementar geração de código
- Validação automática de testes

### Fase 3: Orquestração
- Agentes trabalham juntos
- CI/CD automático
- Merge automático quando tudo passa

---

## 📈 Benefícios

✅ **Velocidade**
- Desenvolvimento acelerado
- Menos trabalho manual

✅ **Consistência**
- Commits sempre semânticos
- Nomenclatura padronizada
- PRs bem documentadas

✅ **Qualidade**
- Testes automáticos
- Validação antes de merge
- Histórico limpo

✅ **Rastreabilidade**
- Issues vinculadas a PRs
- Commits vinculados a issues
- Histórico completo

---

## ⚙️ Configuração Necessária

```yaml
# .github/workflows/auto-pr.yml
name: Auto PR

on:
  pull_request:
    types: [opened, synchronize]
  
jobs:
  validate:
    runs-on: windows-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      
      - name: Build
        run: build.bat
      
      - name: Test
        run: test\run-tests.bat
      
      - name: Auto-merge
        if: success()
        run: gh pr merge ${{ github.event.pull_request.number }} --merge
```

---

## 🎯 Próximas Ações

1. **Hoje:** Documentar arquitetura (✅ Este arquivo)
2. **Próxima semana:** Expandir `auto-pr.ps1` com criar issues
3. **Próximas 2 semanas:** Integrar com GitHub Webhooks
4. **Próximo mês:** Começar CÓDIGO-AGENT

---

## 📞 Contato & Suporte

Para dúvidas sobre arquitetura de agentes:
- Consulte `SCRIPTS_ARCHIVE.md`
- Consulte `AUTO-PR_GUIDE.md`
- Verifique padrões em `docs/branching-strategy.md`

---

**Criado em:** 2026-06-05  
**Versão:** 1.0  
**Status:** 🔄 Planejamento Ativo

