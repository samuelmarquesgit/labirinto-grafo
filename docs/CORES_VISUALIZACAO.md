# Sistema de Cores — Visualização do Labirinto

## Visão Geral

O projeto **labirinto-grafo** utiliza um **sistema de colorização profissional** para melhorar a visualização do algoritmo BFS/Dijkstra em execução. As cores são aplicadas dinamicamente durante a animação, criando uma experiência visual clara e didática.

---

## Paleta de Cores

| Elemento | Cor | Código | Significado |
|----------|-----|--------|-------------|
| **E** (Entrada) | 🔴 **Vermelho** | `12` | Ponto de início da busca |
| **S** (Saída) | 🟢 **Verde** | `10` | Ponto de destino |
| **:** (Visitado) | 🔴 **Vermelho** | `12` | Nó explorado durante BFS/Dijkstra |
| **\*** (Caminho - fase 2) | 🔵 **Azul** | `9` | Caminho sendo reconstruído |
| **\*** (Caminho - final) | 🟢 **Verde** | `10` | Caminho final completo |
| **#** (Parede) | ⚪ **Branco** | `7` | Obstáculo (não percorrível) |
| **·** (Livre) | ⚪ **Branco** | `7` | Célula não explorada |

---

## Fluxo de Cores Durante Execução

### Fase 1: Exploração (BFS/Dijkstra)
```
┌─────────────────────────────────────────────────┐
│  E (🔴 VERMELHO) → : (🔴 VERMELHO)             │
│                                                  │
│  A onda de exploração marca os nós visitados    │
│  em VERMELHO, criando uma visualização clara    │
│  da expansão da busca em todas as direções.     │
└─────────────────────────────────────────────────┘
```

**O que você vê:**
- Entrada **E** em vermelho no canto superior esquerdo
- Caracteres ":" em vermelho se propagando como onda
- Caracteres ":" mostram quais nós foram explorados
- Saída **S** em verde permanecendo no canto

### Fase 2: Reconstrução do Caminho (Asterisco Azul)
```
┌─────────────────────────────────────────────────┐
│  E (🔴) ──→ * (🔵 AZUL) ──→ * (🔵) ──→ S (🟢) │
│                                                  │
│  O caminho mínimo é desenhado em AZUL           │
│  passo a passo, desde a entrada até a saída     │
└─────────────────────────────────────────────────┘
```

**O que você vê:**
- Asteriscos "*" aparecem em **AZUL** enquanto o caminho está sendo reconstruído
- A sequência de "*" mostra o caminho mais curto passo a passo
- Entrada **E** e saída **S** permanecem em suas cores originais

### Fase 3: Resultado Final (Asterisco Verde)
```
┌─────────────────────────────────────────────────┐
│  E (🔴 VERMELHO) ──→ * (🟢 VERDE) ──→ S (🟢)   │
│                                                  │
│  Resultado final: todo o caminho em VERDE       │
└─────────────────────────────────────────────────┘
```

**O que você vê:**
- O labirinto completo é exibido uma última vez
- Entrada **E** em vermelho
- Saída **S** em verde
- **Caminho completo em VERDE**, indicando a solução final

---

## Implementação Técnica

### Estrutura de Cores (visualizacao.h)
```c
#define COR_PADRAO    7   /* Branco */
#define COR_VERMELHO  12  /* Vermelho intenso */
#define COR_VERDE     10  /* Verde intenso */
#define COR_AZUL      9   /* Azul intenso */
#define COR_AMARELO   14  /* Amarelo */
```

### Funções de Colorização (visualizacao.c)

#### `void definirCor(int cor)`
Define a cor do próximo texto a ser impresso.
```c
definirCor(12);  /* Muda para vermelho */
printf("Texto em vermelho\n");
restaurarCor();  /* Volta ao branco */
```

#### `void restaurarCor(void)`
Restaura a cor padrão (branco). Deve ser chamada após cada `definirCor()`.

#### `void exibirLabirintoComCores(const Labirinto *lab, int corAsterisco)`
Exibe o labirinto com colorização automática:
- **E** → Vermelho
- **S** → Verde
- **:** → Vermelho
- **\*** → Cor passada como parâmetro
- Resto → Branco (padrão)

---

## Compatibilidade Multiplataforma

### Windows ✅
- Usa `SetConsoleTextAttribute()` da API do Windows
- Suporta todas as cores definidas
- Operacional em cmd.exe e PowerShell

### Linux/macOS ⚠️
- As funções de cor utilizam `#ifdef _WIN32` para compilação condicional
- Em sistemas Unix-like, as funções de cor são compiladas mas **não fazem nada**
- O programa ainda funciona (sem cores, em branco)
- Possível extensão futura com ANSI escape codes (`\033[38;5;...m`)

---

## Instruções de Uso

### Para Executar com Cores
1. **Compile o programa:**
   ```bash
   build.bat
   ```

2. **Execute o programa:**
   ```bash
   bin\labirinto.exe
   ```

3. **Selecione uma opção no menu:**
   - `1` - BFS (com cores)
   - `2` - Dijkstra (com cores)

4. **Observe a animação:**
   - Fase 1: Exploração em **Vermelho**
   - Fase 2: Caminho em **Azul**
   - Fase 3: Resultado em **Verde**

### Desabilitar Cores (se necessário)
Para desabilitar temporariamente as cores, modifique `animarBusca()` em `visualizacao.c` para chamar `exibirLabirinto()` em vez de `exibirLabirintoComCores()`:

```c
exibirLabirinto(&trabalho);  /* Sem cores */
```

---

## Exemplos de Visualização

### Exemplo 1: Labirinto 5x5
```
Fase 1 (Exploração - Vermelho):
#####
🔴...#
#.#.#
#...🟢
#####

Fase 2 (Caminho - Azul):
#####
🔴🔵🔵#
#.#🔵#
#...🟢
#####

Fase 3 (Final - Verde):
#####
🔴🟢🟢#
#.#🟢#
#...🟢
#####
```

---

## Manutenção e Futuras Melhorias

### Possíveis Extensões
1. **Cores diferentes para nós visitados vs. explorados**
   - Visitados: Vermelho claro
   - Explorados: Vermelho escuro

2. **Suporte a ANSI colors em Linux/macOS**
   - Usar `\033[38;5;...m` para colores ANSI
   - Detectar suporte com `isatty()`

3. **Modo escuro**
   - Adicionar tema de cores para fundo escuro
   - Usar cores mais claras para contraste

4. **Configuração de cores via CLI**
   - Permitir que o usuário escolha as cores
   - Arquivo de configuração `.labiritorc`

---

## Referências

- **Windows Console Colors**: https://docs.microsoft.com/en-us/windows/console/console-screen-buffers#character-attributes
- **ANSI Color Codes**: https://en.wikipedia.org/wiki/ANSI_escape_code
- **C ANSI Compatibility**: ISO/IEC 9899:1990 (C89)

