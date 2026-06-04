# Documento de Entrega — Labirinto com Grafos

> Documento exigido na **seção 11** do enunciado. Preencha os campos marcados
> com `<...>` antes de entregar.

## 1. Integrantes

| Nome completo | Matrícula     |
|---------------|---------------|
| `<Samuel Magalhaes Marques>` | `<1332130>` |
| `<Wilson de Morais>` | `<1332584>` |
| `<integrante 3>` | `<matrícula>` |

**Disciplina:** Estrutura de Dados — Avaliação N3
**Data de entrega:** 25/06/2026

## 2. Explicação do problema

O problema consiste em encontrar uma rota entre a **entrada** e a **saída** de um
labirinto, percorrendo apenas posições livres e desviando das paredes. Esse tipo
de problema aparece em aplicativos de navegação, robôs, jogos e logística.

Neste trabalho, o labirinto é tratado como um **grafo**: cada posição livre é um
**vértice** e cada movimento possível entre posições vizinhas é uma **aresta**.
O objetivo é encontrar o **menor caminho** (menor número de passos) entre a
entrada `E` e a saída `S`.

## 3. Como o labirinto foi representado

- O labirinto é armazenado em uma **matriz de caracteres**, dentro de uma
  `struct Labirinto` (`char grade[MAX_LINHAS][MAX_COLUNAS]` + dimensões).
- Significado dos caracteres:
  - `#` parede;
  - `.` caminho livre;
  - `E` entrada;
  - `S` saída;
  - `:` posição visitada (aparece só na animação);
  - `*` caminho encontrado pelo algoritmo.
- Uma `struct Posicao { int linha; int coluna; }` representa cada vértice
  (uma célula da matriz).

## 4. Explicação do algoritmo utilizado

Foram implementados **dois** algoritmos de busca: a **BFS (Busca em Largura)**,
usada como principal, e o **Dijkstra**, para comparação.

**Justificativa da BFS:** cada movimento custa exatamente 1 passo. Quando todas
as arestas têm o mesmo peso, a BFS visita as posições em ordem crescente de
distância da entrada, garantindo que, ao alcançar a saída, o caminho é o
**menor possível**. Por isso a BFS é suficiente.

**Funcionamento da BFS (resumido):**
1. A entrada é marcada como visitada e colocada em uma **fila**.
2. Enquanto a fila não estiver vazia, retira-se a primeira posição e tentam-se os
   4 vizinhos (cima, baixo, esquerda, direita).
3. Cada vizinho livre e ainda não visitado é marcado, tem seu **predecessor**
   registrado (matriz `pai`) e entra na fila.
4. Ao alcançar a saída, o caminho é **reconstruído** seguindo os predecessores da
   saída até a entrada, marcando cada passo com `*`.
5. Se a fila esvazia sem alcançar a saída, **não existe caminho**.

**Sobre o Dijkstra:** ele resolve o mesmo problema usando **distâncias** (em vez
de fila). Como todos os pesos são 1, encontra **exatamente o mesmo** menor
caminho da BFS — incluímos para demonstrar o caso geral.

Veja a explicação completa em
[`explicacao-algoritmo.md`](explicacao-algoritmo.md).

## 5. Exemplo de execução

Veja [`exemplo-execucao.md`](exemplo-execucao.md) para a saída completa
(menu, labirinto original e resolvido).

## 6. Capturas de tela

> Cole aqui as capturas de tela do programa em execução (labirinto original e
> labirinto resolvido), conforme exigido pelo enunciado.

- `<imagem 1: labirinto original>`
- `<imagem 2: labirinto resolvido>`

## 7. Como compilar e executar

```bat
build.bat        :: compila labirinto.exe e testes.exe
labirinto.exe    :: roda o programa (menu de algoritmos)
```

> O núcleo é **C ANSI** e compila com `gcc -ansi -pedantic -Wall labirinto.c
> testes.c`. A animação/áudio (`visualizacao.c`) usa `windows.h` e é um extra
> didático, compilado sem `-ansi`.
