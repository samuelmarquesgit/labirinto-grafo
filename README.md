# Labirinto com Grafos — Busca do Menor Caminho

Trabalho da disciplina de **Estrutura de Dados (Avaliação N3)**.
Programa em **C ANSI**, modo console, que representa um labirinto como um
**grafo** e encontra o **menor caminho** entre a entrada (`E`) e a saída (`S`).
Implementa **dois algoritmos** de busca — **BFS (Busca em Largura)** e
**Dijkstra** — e ainda oferece uma **animação com áudio** opcional, para fins
didáticos.

---

## Visão geral

- Cada posição **livre** do labirinto é um **vértice**.
- Cada par de posições livres **vizinhas** (cima, baixo, esquerda, direita) é
  ligado por uma **aresta**.
- As **paredes** (`#`) não são vértices.
- Como todo movimento "custa" 1 passo, a **BFS garante o menor caminho** em
  número de passos. O **Dijkstra** chega ao mesmo resultado (pois o peso é 1) e
  está incluído para comparação didática.

## Funcionalidades

- Resolução por **BFS** e por **Dijkstra**.
- **Modo estático**: mostra o labirinto original e o resolvido de uma vez.
- **Modo animado**: desenha a exploração da busca passo a passo, em tempo real.
- **Áudio opcional**: emite sons durante a animação (tocados em paralelo, numa
  *thread*, para não travar o desenho).
- **Detecção de "sem caminho"**: avisa claramente quando não há rota.
- **Bateria de testes** automatizada (`testes.c`).

## Como compilar e executar (Windows 11 + MinGW/gcc)

Forma mais fácil — use os scripts `.bat`:

```bat
build.bat        :: compila o programa (labirinto.exe) e os testes (testes.exe)
labirinto.exe    :: roda o programa (menu de algoritmos/animacao)
run-tests.bat    :: compila e roda só os testes
```

Ou manualmente:

```bat
:: Programa (com animacao + audio): usa windows.h, por isso SEM -ansi
gcc -Wall labirinto.c visualizacao.c main.c -o labirinto.exe

:: Testes e nucleo: C ANSI puro
gcc -ansi -pedantic -Wall labirinto.c testes.c -o testes.exe
```

> O **núcleo** (`labirinto.c`) é **C ANSI (C89)** e compila limpo com
> `-ansi -pedantic`. A **animação + áudio** (`visualizacao.c`) usa `windows.h`
> (`Beep`, `Sleep`, *threads*) e por isso é compilada sem `-ansi` — é um recurso
> didático extra, não faz parte do núcleo exigido pelo trabalho.

## Menu do programa

```
========= LABIRINTO COM GRAFOS (BFS) =========
1 - Busca em Largura (BFS)  (Sem Audio)
2 - Busca em Largura (BFS)  (Com Audio)
3 - Algoritmo de Dijkstra (Sem Audio)
4 - Algoritmo de Dijkstra (Com Audio)
5 - Mostrar resolucao (estatico)
0 - Sair
```

## Legenda dos caracteres

| Caractere | Significado                       |
|-----------|-----------------------------------|
| `#`       | Parede (bloqueado)                |
| `.`       | Caminho livre                     |
| `E`       | Entrada                           |
| `S`       | Saída                             |
| `:`       | Posição visitada (só na animação) |
| `*`       | Caminho encontrado                |

## Estrutura do repositório

```
labirinto-grafo/
│
├── CODIGO-FONTE (RAIZ)
│   ├── labirinto.c         # Nucleo: BFS, Dijkstra
│   ├── labirinto.h         # Tipos e assinaturas
│   ├── visualizacao.c      # Animacao + audio (Windows)
│   ├── visualizacao.h      # Assinatura da animacao
│   ├── main.c              # Menu e orquestracao
│   ├── build.bat           # Compila programa + testes → bin/
│   ├── README.md           # Este arquivo
│   ├── Planejamento.md     # Enunciado original
│   ├── .gitignore          # Ignora executaveis
│   └── .vscode/            # Config do IntelliSense
│
├── bin/                    # EXECUTAVEIS (gerados por build.bat)
│   ├── labirinto.exe       # Programa compilado
│   ├── testes.exe          # Testes compilados
│   └── teste-som.exe       # Teste isolado de audio
│
├── test/                   # TESTES
│   ├── testes.c            # 8 testes unitarios (assert.h, C ANSI)
│   ├── teste-som.c         # Teste isolado de audio
│   └── run-tests.bat       # Executa bin/testes.exe
│
├── scripts/                # SCRIPTS DE AUTOMACAO
│   ├── auto-pr.ps1         # Git automatico (detecta diff → PR)
│   ├── LIMPAR.ps1          # Limpeza de temporarios
│   └── README.md           # Documentacao dos scripts
│
├── docs/                   # DOCUMENTACAO OFICIAL
│   ├── documento-entrega.md      # Secao 11 do enunciado ⭐
│   ├── guia-apresentacao.md      # Teste de autoria
│   ├── checklist-entrega.md      # Conferencia de requisitos
│   ├── explicacao-algoritmo.md   # BFS e Dijkstra
│   ├── exemplo-execucao.md       # Exemplos de saida
│   ├── testes.md                 # Documentacao dos testes
│   ├── glossario.md              # Termos de grafos
│   ├── roteiro-video.md          # Roteiro narrado
│   ├── branching-strategy.md     # Estrategia de branches
│   ├── quick-start-branching.md  # Git quick start
│   ├── auto-pr-guide.md          # Guia do auto-pr.ps1
│   ├── agents-plan.md            # Plano de agentes futuros
│   ├── scripts-archive.md        # Todos os scripts
│   └── batch-scripts-archive.md  # Scripts .bat documentados
│
├── specs/                  # ESPECIFICACOES
│   ├── requirements.md     # Requisitos funcionais (RF-01 a RF-10)
│   ├── design.md           # Design e arquitetura
│   └── tasks.md            # Checklist de tarefas
│
├── steering/               # DIRETRIZES
│   ├── product.md          # O que e o produto, para quem
│   ├── tech.md             # Como e construido
│   └── structure.md        # Organizacao de arquivos
│
├── .github/                # CONFIGURACAO GITHUB
│   └── pull_request_template.md  # Template de PR
│
└── .git/                   # REPOSITORIO GIT
```

## Arquitetura (resumo)

| Módulo           | Responsabilidade                                  | É ANSI? |
|------------------|---------------------------------------------------|---------|
| `labirinto.c/.h` | Carregar, exibir, localizar, **BFS** e **Dijkstra** | ✅ Sim  |
| `visualizacao.c` | Animar a busca + emitir som (em *thread* paralela) | ❌ Win  |
| `main.c`         | Menu e orquestração                               | ✅ Sim* |
| `testes.c`       | Validação automática com `assert`                 | ✅ Sim  |

\* `main.c` só chama a animação; a parte não-ANSI fica contida em `visualizacao.c`.

## Documentos importantes

- **⭐ Para a entrega (Seção 11):**
  [`docs/documento-entrega.md`](docs/documento-entrega.md)
- **Para o teste de autoria:**
  [`docs/guia-apresentacao.md`](docs/guia-apresentacao.md)
- **Checklist de requisitos:**
  [`docs/checklist-entrega.md`](docs/checklist-entrega.md)
- **Explicação dos algoritmos:**
  [`docs/explicacao-algoritmo.md`](docs/explicacao-algoritmo.md)
- **Especificação:** 
  [`specs/requirements.md`](specs/requirements.md),
  [`specs/design.md`](specs/design.md),
  [`specs/tasks.md`](specs/tasks.md)
- **Estratégia de Git:**
  [`docs/branching-strategy.md`](docs/branching-strategy.md),
  [`docs/quick-start-branching.md`](docs/quick-start-branching.md)
- **Scripts de Automação:**
  [`scripts/auto-pr.ps1`](scripts/auto-pr.ps1),
  [`docs/auto-pr-guide.md`](docs/auto-pr-guide.md)

## Integrantes

> Preencha em [`docs/documento-entrega.md`](docs/documento-entrega.md).

## Entrega

Data limite: **25/06/2026**.
