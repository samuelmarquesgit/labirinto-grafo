# Guia de Apresentação — Teste de Autoria

Documento de bolso para a apresentação. Para cada pedido provável do professor,
há: **o que falar** (resposta curta) e **onde mostrar** (arquivo/função). Treine
lendo em voz alta.

> 🎯 Regra de ouro: fale sempre ligando **labirinto → grafo**. "Posição livre é
> **vértice**, passagem entre vizinhos é **aresta**, achar a saída é achar um
> **caminho** no grafo."

---

## PARTE 1 — O que o professor pode SOLICITAR

### 1.1 Execução completa do programa

**Roteiro de demonstração (faça nesta ordem):**
1. Abra o terminal na pasta e rode `.\build.bat` (mostra que **compila**).
2. Rode `.\testes.exe` → mostra "TODOS OS TESTES PASSARAM" (prova que está correto).
3. Rode `.\labirinto.exe`.
4. Escolha **opção 5** (estático): mostra labirinto original e resolvido + passos.
5. Escolha **opção 2** (BFS com áudio): mostra a animação da busca.
6. Escolha **opção 4** (Dijkstra com áudio): mostra o outro algoritmo.

> "O programa carrega o labirinto, deixa eu escolher o algoritmo, resolve e
> mostra o menor caminho marcado com `*`, junto com a quantidade de passos."

### 1.2 Explicação da matriz do labirinto

**Onde:** `labirinto.h` → `char grade[MAX_LINHAS][MAX_COLUNAS]` dentro da `struct
Labirinto`. Preenchida em `labirinto.c` → `carregarDoVetor`.

> "O labirinto é uma **matriz de caracteres**. Cada caractere tem um significado:
> `#` é parede, `.` é caminho livre, `E` é a entrada, `S` é a saída e `*` é o
> caminho encontrado. A função `carregarDoVetor` copia o desenho para essa
> matriz e descobre o número de linhas e colunas."

### 1.3 Como o labirinto representa um grafo

> "Embora eu **mostre** uma matriz, eu a **trato** como um grafo. Cada posição
> livre é um **vértice**. Se duas posições livres são vizinhas (cima, baixo,
> esquerda ou direita), existe uma **aresta** entre elas. As paredes não são
> vértices. É um **grafo implícito**: eu não guardo uma lista de conexões; eu
> calculo os vizinhos na hora, somando os deslocamentos."

**Onde:** vetores `deslocaLinha`/`deslocaColuna` em `labirinto.c`.

### 1.4 Vértices e arestas

> "**Vértice** = uma célula livre, representada pela `struct Posicao` (linha e
> coluna). **Aresta** = o movimento de uma célula para uma vizinha livre. Como
> só ando em 4 direções, cada vértice tem no máximo 4 arestas."

**Onde:** `Posicao` em `labirinto.h`; o cálculo dos vizinhos no laço da busca.

### 1.5 Algoritmo de busca utilizado

> "Eu implementei **dois**: a **BFS (Busca em Largura)** e o **Dijkstra**. Usei
> principalmente a BFS porque cada movimento custa **1 passo** — e, com pesos
> iguais, a BFS já garante o **menor caminho**. A BFS funciona como uma onda:
> visita primeiro o que está a 1 passo, depois a 2, e assim por diante. Quando a
> onda toca a saída, é pelo menor número de passos. O Dijkstra dá o mesmo
> resultado aqui; a diferença é que ele usa **distâncias** em vez de uma fila."

**Onde:** `labirinto.c` → `resolverLabirinto` (BFS) e `resolverDijkstra`.

### 1.6 Controle de posições visitadas

> "Eu uso a matriz **`visitado`**. Quando entro numa posição, marco como
> visitada. Antes de entrar em qualquer vizinho, checo essa matriz. Isso evita
> visitar a mesma posição duas vezes e impede **loops infinitos**."

**Onde:** `labirinto.c` → `int visitado[][]` em `resolverLabirinto`.

### 1.7 Reconstrução do caminho

> "Durante a busca, para cada posição eu guardo **de onde cheguei nela**, na
> matriz **`pai`**. No fim, eu começo na **saída** e vou seguindo os `pais` de
> volta até a **entrada** — como um rastro de migalhas. Depois inverto a lista
> para que comece na entrada, e marco cada posição com `*`."

**Onde:** `labirinto.c` → matriz `pai` + laço de reconstrução; marcação em
`marcarCaminho`.

### 1.8 Alteração simples no labirinto (AO VIVO)

**Onde:** `main.c` → função `carregarPadrao`, vetor `desenho`.

**O que fazer:** troque um `.` por `#` (ou vice-versa) para criar/fechar uma
passagem. Salve, rode `.\build.bat` e `.\labirinto.exe`.

> "Posso fechar este corredor trocando um ponto por um `#`. Recompilando, o
> programa acha **outro** caminho — ou avisa que não há caminho, se eu bloquear
> tudo."

💡 **Dica:** tenha o `main.c` já aberto na linha do labirinto antes de começar.

### 1.9 Alteração simples no código (AO VIVO)

Exemplos fáceis e seguros de mudar na hora:
- **Trocar o caractere do caminho** de `*` para outro (ex.: `+`): em
  `labirinto.c` → `marcarCaminho`, linha `lab->grade[...] = '*';`.
- **Mudar a velocidade da animação:** em `main.c`, os números `25` e `130` na
  chamada `animarBusca(...)`.
- **Mudar a frequência do som:** em `visualizacao.c`, `INTERVALO_SOM`.

### 1.10 Teste com outro labirinto

Mesma coisa do 1.8: edite o vetor `desenho` em `carregarPadrao` (pode colar um
labirinto totalmente diferente, só mantenha um `E` e um `S`), recompile e rode.

> ⚠️ Cuidado: mantenha **um único `E`** e **um único `S`**, e cerque o labirinto
> com paredes na borda para o programa não tentar sair da matriz.

### 1.11 Correção de pequenos problemas durante a apresentação

Veja a tabela de "Consertos rápidos" na PARTE 3.

---

## PARTE 2 — Conhecimentos que CADA aluno deve dominar

Respostas de 1 frase para perguntas diretas:

| Tema | Resposta de bolso |
|------|-------------------|
| **Matriz** | Tabela 2D de caracteres (`grade[linha][coluna]`) que guarda o labirinto. |
| **Funções** | Cada tarefa é uma função: carregar, exibir, localizar, resolver, marcar. Facilita ler e testar. |
| **Struct** | `Posicao` agrupa `linha` e `coluna` num só tipo; representa um vértice. `Labirinto` agrupa a grade e seu tamanho. |
| **Grafos** | Estrutura de vértices ligados por arestas; aqui o labirinto é um grafo de posições. |
| **Vértices** | Cada posição livre do labirinto. |
| **Arestas** | A ligação entre duas posições vizinhas livres (um movimento). |
| **Controle de visitados** | Matriz `visitado` que impede repetir posições e entrar em loop. |
| **Algoritmo de busca** | BFS (e Dijkstra); acha o menor caminho da entrada à saída. |
| **Reconstrução do caminho** | Matriz `pai` guarda de onde vim; sigo da saída até a entrada para refazer o caminho. |
| **Funcionamento geral** | Carrega a matriz → trata como grafo → BFS acha o menor caminho → marca com `*` → mostra e conta os passos. |

---

## PARTE 3 — Consertos rápidos (se algo der errado ao vivo)

| Problema | Causa provável | Solução rápida |
|----------|----------------|----------------|
| `gcc não reconhecido` | PATH/terminal | Use o terminal certo; confirme `gcc --version`. |
| Não compila após editar | Erro de digitação na edição | Leia a mensagem do gcc: ela diz o arquivo e a linha. Desfaça a última edição (`Ctrl+Z`). |
| "Nao existe caminho" inesperado | Bloqueou o labirinto sem querer | Confira se a borda não fechou a única passagem; verifique se há `E` e `S`. |
| Caminho não aparece | Esqueceu de recompilar | Rode `.\build.bat` de novo antes de `.\labirinto.exe`. |
| Som não sai | Terminal/volume | Rode dando duplo-clique no `.exe` (console clássico); o som usa `Beep`. |
| Animação muito rápida/lenta | delays | Ajuste os números em `animarBusca(...)` no `main.c`. |
| Programa "trava" no menu | Digitou letra em vez de número | O `scanf` espera um número; reinicie e digite 0–5. |

> 🧯 **Plano B universal:** se uma edição ao vivo quebrar tudo, dê `Ctrl+Z` até
> voltar, ou feche sem salvar e reabra o arquivo. Tenha um backup da pasta.

---

## PARTE 4 — Roteiro de fala de abertura (30 segundos)

> "Nosso trabalho resolve um **labirinto** usando **grafos**. O labirinto é uma
> **matriz de caracteres**, mas a gente trata cada espaço livre como um
> **vértice** e cada passagem entre vizinhos como uma **aresta**. Para achar o
> **menor caminho** da entrada `E` até a saída `S`, usamos a **Busca em Largura
> (BFS)** — e também implementamos o **Dijkstra** para comparar. O programa
> mostra a busca acontecendo, marca o caminho com `*` e informa quantos passos
> tem. Posso demonstrar?"

---

## PARTE 5 — Divisão sugerida entre integrantes

Como **todos** podem ser perguntados, todos estudam tudo. Mas para a
apresentação fluir, sugira papéis:

- **Integrante 1:** abertura + execução (PARTE 1.1) + matriz (1.2).
- **Integrante 2:** grafo, vértices e arestas (1.3, 1.4) + struct.
- **Integrante 3:** algoritmo (1.5), visitados (1.6) e reconstrução (1.7).
- **Todos:** revezam nas alterações ao vivo (1.8–1.10).

> Treinem trocando os papéis ao menos uma vez — o professor pode perguntar a
> qualquer um sobre qualquer parte.
