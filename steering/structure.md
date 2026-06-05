# Steering — Estrutura

Diretrizes sobre a **organização** do projeto.

## Árvore de arquivos

```
labirinto-grafo/
│
├── scripts/                     # AUTOMACAO (scripts para CI/CD)
│   ├── README.md                #   documentacao dos scripts
│   ├── limpar-projeto.bat       #   limpeza de temporarios
│   └── ...
│
├── bin/                         # BINARIOS (gerados por build.bat)
│   ├── labirinto.exe            #   programa compilado
│   ├── testes.exe               #   testes compilados
│   └── teste-som.exe            #   teste de audio isolado
│
├── test/                        # TESTES
│   ├── testes.c                 #   8 testes unitarios (assert.h, C ANSI)
│   ├── teste-som.c              #   3 testes de audio (Beep)
│   └── run-tests.bat            #   script para rodar testes
│
├── labirinto.h                  # Tipos (Posicao, Labirinto, Resultado) + assinaturas
├── labirinto.c                  # NUCLEO ANSI: carregar, exibir, localizar,
│                                #   ehLivre, resolverLabirinto (BFS),
│                                #   resolverDijkstra, marcarCaminho
├── visualizacao.h               # Assinatura de animarBusca
├── visualizacao.c               # Animacao + audio (Windows): threads, Beep,
│                                #   reposicionamento de cursor
├── main.c                       # Menu e orquestracao (int main(void))
│
├── build.bat                    # Compila programa + testes → bin/
│
├── .gitignore                   # Ignora executaveis e temporarios
├── .vscode/                     # Config do IntelliSense (caminho do gcc)
│
├── README.md                    # Apresentacao e instrucoes (UNICO .md NA RAIZ)
├── Planejamento.md              # Enunciado original do trabalho
│
├── specs/                       # ESPECIFICACAO
│   ├── requirements.md          #   o que o programa deve fazer
│   ├── design.md                #   como foi projetado (decisoes)
│   └── tasks.md                 #   tarefas e checklist
│
├── steering/                    # DIRETRIZES
│   ├── product.md               #   o que e o produto e para quem
│   ├── tech.md                  #   como e construido (padrao, build)
│   └── structure.md             #   este arquivo
│
├── docs/                        # DOCUMENTACAO DE APOIO E ENTREGA
│   ├── documento-entrega.md     #   documento exigido (secao 11)
│   ├── guia-apresentacao.md     #   roteiro para teste de autoria
│   ├── checklist-entrega.md     #   conferencia dos requisitos
│   ├── roteiro-video.md         #   roteiro narrado do funcionamento
│   ├── explicacao-algoritmo.md  #   BFS e Dijkstra em detalhe
│   ├── exemplo-execucao.md      #   exemplo de saida
│   ├── testes.md                #   como os testes funcionam
│   ├── glossario.md             #   termos de grafos e do codigo
│   ├── branching-strategy.md    #   estrategia de branches Git
│   ├── quick-start-branching.md #   guia rapido de Git
│   └── INDEX.md                 #   indice central de docs
│
├── .github/                     # CONFIGURACAO DO GITHUB
│   └── pull_request_template.md #   template automatico de PR
│
└── .git/                        # REPOSITORIO GIT
```

## Por que vários arquivos (módulos)?

O projeto é dividido em módulos com responsabilidades claras. Isso facilita
**explicar parte por parte** no teste de autoria e permite **testar a lógica**
isoladamente (o `testes.c` usa só o núcleo, sem a parte gráfica).

| Módulo | Responsabilidade | C ANSI? |
|--------|------------------|:-------:|
| `labirinto.c/.h` | Toda a lógica (matriz, grafo, BFS, Dijkstra) | ✅ |
| `visualizacao.c/.h` | Animação na tela + áudio | ❌ (Windows) |
| `main.c` | Menu e orquestração | ✅* |
| `testes.c` | Testes automatizados | ✅ |

\* `main.c` é ANSI; só chama a animação, cuja parte não-ANSI fica em `visualizacao.c`.

## Organização interna do `labirinto.c`

Ordem, de cima para baixo:

1. `#include` (`stdio.h`, `labirinto.h`) e os vetores de deslocamento.
2. `carregarDoVetor` — monta a matriz a partir de um vetor de strings.
3. `exibirLabirinto` — imprime a matriz.
4. `localizar` — acha `E` ou `S`.
5. `ehLivre` — valida limites e paredes.
6. `resolverLabirinto` — **BFS** (fila + reconstrução).
7. `resolverDijkstra` — **Dijkstra** (distâncias + reconstrução).
8. `marcarCaminho` — escreve `*` no caminho.

## Organização interna do `visualizacao.c`

1. Funções de console: `limparTela`, `irParaTopo`, `cursorVisivel`, `esperar`.
2. Áudio: `bip` (síncrono) e `bipAssincrono` (em *thread*, via `CreateThread`).
3. `animarBusca` — orquestra as fases de exploração e de caminho.

## Princípios de organização

- **Núcleo separado da apresentação:** lógica em `labirinto.c`, visual em
  `visualizacao.c`. Trocar o visual não afeta a lógica.
- **Cada função tem uma responsabilidade clara.**
- **Documentação separada:** `specs/` (o quê/como projetar), `steering/`
  (diretrizes) e `docs/` (apoio e entrega).

## Onde mexer para...

| Quero...                          | Edite...                                       |
|-----------------------------------|------------------------------------------------|
| Trocar o labirinto                | vetor `desenho` em `carregarPadrao()` (`main.c`)|
| Usar labirinto maior              | `MAX_LINHAS` / `MAX_COLUNAS` (`labirinto.h`)   |
| Mudar o caractere do caminho      | `'*'` em `marcarCaminho()` (`labirinto.c`)     |
| Mudar a velocidade da animação    | delays na chamada `animarBusca(...)` (`main.c`)|
| Mudar a frequência do som         | `INTERVALO_SOM` e os `freq` (`visualizacao.c`) |
| Adicionar/editar opção do menu    | laço `while` de `main()` (`main.c`)            |
