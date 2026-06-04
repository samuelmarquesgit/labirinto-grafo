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
├── labirinto.h         # Tipos e assinaturas (nucleo ANSI)
├── labirinto.c         # Logica: carregar, exibir, localizar, BFS, Dijkstra
├── visualizacao.h      # Assinatura da animacao
├── visualizacao.c      # Animacao passo a passo + audio (Windows)
├── main.c              # Programa com menu (orquestracao)
├── testes.c            # Bateria de testes (assert.h, C ANSI)
├── teste-som.c         # Teste isolado de audio (diagnostico do Beep)
├── build.bat           # Compila programa + testes (Windows)
├── run-tests.bat       # Compila e roda os testes
├── .gitignore          # Ignora executaveis e temporarios
├── .vscode/            # Config do IntelliSense (c_cpp_properties.json)
├── README.md           # Este arquivo
├── Planejamento.md     # Enunciado original do trabalho
├── specs/              # Especificação
│   ├── requirements.md #   o que o programa deve fazer
│   ├── design.md       #   como foi projetado (decisões)
│   └── tasks.md        #   tarefas e checklist
├── steering/           # Diretrizes do projeto
│   ├── product.md      #   o que é o produto e para quem
│   ├── tech.md         #   como é construído (padrão, build)
│   └── structure.md    #   organização de arquivos e código
└── docs/               # Documentos de apoio e entrega
    ├── documento-entrega.md    # documento exigido na entrega
    ├── guia-apresentacao.md    # roteiro para o teste de autoria
    ├── checklist-entrega.md    # conferência dos requisitos
    ├── roteiro-video.md        # roteiro narrado do funcionamento
    ├── explicacao-algoritmo.md # BFS e Dijkstra em detalhe
    ├── exemplo-execucao.md     # exemplo de saída
    ├── testes.md               # como os testes funcionam
    └── glossario.md            # termos de grafos e do código
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

- **Para a apresentação (teste de autoria):**
  [`docs/guia-apresentacao.md`](docs/guia-apresentacao.md)
- **Conferência dos requisitos:**
  [`docs/checklist-entrega.md`](docs/checklist-entrega.md)
- **Documento de entrega (preencher integrantes):**
  [`docs/documento-entrega.md`](docs/documento-entrega.md)
- **Explicação dos algoritmos:**
  [`docs/explicacao-algoritmo.md`](docs/explicacao-algoritmo.md)
- **Especificação:** [`specs/requirements.md`](specs/requirements.md),
  [`specs/design.md`](specs/design.md), [`specs/tasks.md`](specs/tasks.md)

## Integrantes

> Preencha em [`docs/documento-entrega.md`](docs/documento-entrega.md).

## Entrega

Data limite: **25/06/2026**.
