# Implementação: Sistema de Cores para Visualização

## Resumo Executivo

Foi implementado um **sistema de colorização profissional** no projeto labirinto-grafo para melhorar a didática e a visualização dos algoritmos BFS e Dijkstra. O sistema utiliza as capacidades nativas do Windows Console para colorir dinamicamente os caracteres durante a animação.

---

## O Que Foi Alterado

### 1. Adições a `visualizacao.h`

#### Constantes de Cores
```c
#define COR_PADRAO    7   /* Branco */
#define COR_VERMELHO  12  /* Vermelho intenso */
#define COR_VERDE     10  /* Verde intenso */
#define COR_AZUL      9   /* Azul intenso */
#define COR_AMARELO   14  /* Amarelo */
```

#### Novas Funções (Assinaturas)
```c
void definirCor(int cor);
void restaurarCor(void);
```

#### Atualização da Documentação de `animarBusca()`
Adicionado comentário explicativo sobre as cores usadas em cada fase.

---

### 2. Implementações em `visualizacao.c`

#### Função `definirCor(int cor)`
```c
void definirCor(int cor) {
#ifdef _WIN32
    HANDLE saida = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleTextAttribute(saida, cor);
#else
    (void)cor; /* sem suporte a cores em sistemas nao-Windows */
#endif
}
```
- **Responsabilidade**: Altera a cor do próximo texto impresso no console
- **Plataforma**: Windows (usando `SetConsoleTextAttribute`)
- **Compatibilidade**: Sistemas Unix-like compilam sem erro, mas não aplicam cores

#### Função `restaurarCor(void)`
```c
void restaurarCor(void) {
    definirCor(7); /* COR_PADRAO */
}
```
- **Responsabilidade**: Restaura a cor branca padrão
- **Uso**: Chamada após cada `definirCor()` para evitar colorir texto indesejado

#### Função `exibirLabirintoComCores(const Labirinto *lab, int corAsterisco)`
```c
static void exibirLabirintoComCores(const Labirinto *lab, int corAsterisco) {
    /* Itera sobre a matriz e coloriza caracteres específicos:
       - E (entrada): VERMELHO
       - S (saída): VERDE
       - : (visitado): VERMELHO
       - * (caminho): cor passada como parâmetro
       - resto: BRANCO (padrão)
    */
}
```
- **Responsabilidade**: Exibir o labirinto com cores automáticas
- **Parâmetro `corAsterisco`**: Permite mudar a cor do asterisco entre AZUL (fase 2) e VERDE (resultado final)

#### Modificações em `animarBusca()`
- **Linha 203**: Alterada de `exibirLabirinto()` → `exibirLabirintoComCores()` (caso de erro)
- **Linha 226**: Alterada para usar `exibirLabirintoComCores(&trabalho, 9)` na fase de exploração
- **Linha 250**: Alterada para usar `exibirLabirintoComCores(&trabalho, 9)` durante a reconstrução
- **Linhas 266-269**: Adicionado chamada final com cores (asterisco em VERDE)

---

## Fluxo de Cores Durante Execução

### Fase 1: Exploração (BFS/Dijkstra) — Vermelho
```
caracteres : aparecem em VERMELHO conforme nós são visitados
E permanece VERMELHO (entrada)
S permanece VERDE (saída)
```

### Fase 2: Reconstrução do Caminho — Azul
```
asteriscos * aparecem em AZUL enquanto o caminho é desenhado
E permanece VERMELHO
S permanece VERDE
```

### Fase 3: Resultado Final — Verde
```
O labirinto é exibido uma última vez com asteriscos em VERDE
E em VERMELHO (entrada)
S em VERDE (saída)
* em VERDE (caminho completo)
```

---

## Compatibilidade

### Windows ✅
- **Status**: Totalmente funcional
- **Terminal**: cmd.exe, PowerShell, Windows Terminal
- **Requisitos**: Nenhum (API do Windows nativamente suportada)
- **Compilação**: 
  ```bash
  build.bat
  ```

### Linux/macOS ⚠️
- **Status**: Compila, mas sem cores
- **Razão**: `#ifdef _WIN32` desabilita colorização em não-Windows
- **Compilação**: Ainda funciona (sem erros)
- **Futura melhoria**: Adicionar ANSI escape codes (`\033[38;5;...m`)

---

## Arquivos Modificados

| Arquivo | Tipo | Mudança |
|---------|------|---------|
| `visualizacao.h` | ✏️ Editado | Adicionadas constantes e assinaturas de funções |
| `visualizacao.c` | ✏️ Editado | Implementadas funções de cor e modificada `animarBusca()` |
| `steering/structure.md` | ✏️ Editado | Atualizada seção de organização interna |

---

## Arquivos Criados

| Arquivo | Tipo | Descrição |
|---------|------|-----------|
| `docs/CORES_VISUALIZACAO.md` | 📄 Novo | Documentação completa do sistema de cores |
| `docs/IMPLEMENTACAO_CORES.md` | 📄 Novo | Este arquivo - resumo das alterações |
| `test-compile.bat` | 🔧 Novo | Script para testar compilação rápida |

---

## Como Testar

### 1. Compilação Rápida (Teste de Sintaxe)
```bash
test-compile.bat
```
Verifica se `visualizacao.c` compila sem erros.

### 2. Compilação Completa
```bash
build.bat
```
Gera `bin/labirinto.exe` e outros executáveis.

### 3. Execução com Cores
```bash
bin\labirinto.exe
```
1. Selecione opção `1` (BFS) ou `2` (Dijkstra)
2. Observe as fases de cores:
   - 🔴 Vermelho durante exploração
   - 🔵 Azul durante reconstrução
   - 🟢 Verde no resultado final

---

## Exemplos de Saída

### Terminal During Phase 1 (Exploration)
```
Explorando o labirinto (busca pelo menor caminho)...
Legenda: E=entrada S=saida #=parede :=visitado *=caminho

#####
🔴...#
#.#.#
#...🟢
#####

Visitados: 12 de 15
```

### Terminal During Phase 2 (Path Reconstruction)
```
Reconstruindo o MENOR caminho (entrada -> saida)...
Legenda: E=entrada S=saida #=parede :=visitado *=caminho

#####
🔴🔵🔵#
#.#🔵#
#...🟢
#####

Passo 5 de 7
```

### Terminal After Phase 3 (Final Result)
```
>>> CAMINHO ENCONTRADO! <<<
Legenda: E=entrada S=saida #=parede :=visitado *=caminho

#####
🔴🟢🟢#
#.#🟢#
#...🟢
#####

>>> Caminho encontrado! Quantidade de passos: 6
```

---

## Versões e Histórico

- **v1.0** (Atual): Implementação inicial com Windows Console API
  - 3 constantes de cor principais (Vermelho, Verde, Azul)
  - 2 funções de controle (definirCor, restaurarCor)
  - 1 função de exibição colorida (exibirLabirintoComCores)
  - 3 fases com cores diferentes

---

## Próximos Passos Sugeridos

1. **✅ Testar compilação** (`test-compile.bat`)
2. **✅ Compilar projeto** (`build.bat`)
3. **✅ Executar programa** (`bin\labirinto.exe`)
4. **📋 Fazer commit das mudanças**
   ```bash
   git add -A
   git commit -m "feat(viz): sistema de colorização com 3 fases (vermelho/azul/verde)"
   ```
5. **📋 Criar Pull Request**
   ```bash
   .\scripts\auto-pr.ps1 feat viz "Sistema de colorização para visualização"
   ```

---

## Troubleshooting

### Cores não aparecem no PowerShell?
- Tente usar `Windows Terminal` (mais recente, melhor suporte)
- Ou execute dentro de `cmd.exe`

### Erro de compilação "SetConsoleTextAttribute"?
- Certifique-se de compilar sem `-ansi -pedantic` para `visualizacao.c`
- `build.bat` já faz isso corretamente

### Linux/macOS compila mas sem cores?
- Esperado! Use `#ifdef _WIN32` em `visualizacao.c`
- Extensão futura pode adicionar ANSI codes

---

## Referências Técnicas

- **Windows Console API**: https://docs.microsoft.com/en-us/windows/console/
- **SetConsoleTextAttribute**: https://docs.microsoft.com/en-us/windows/console/setconsoletextattribute
- **ANSI Escape Codes**: https://en.wikipedia.org/wiki/ANSI_escape_code
- **C89 Compatibility**: ISO/IEC 9899:1990

