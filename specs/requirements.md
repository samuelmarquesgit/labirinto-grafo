# Requisitos — Labirinto com Grafos

Documento de especificação dos requisitos do trabalho, derivado do enunciado
([`../Planejamento.md`](../Planejamento.md)).

## 1. Objetivo

Desenvolver um programa em **C ANSI**, modo console, que:

1. Represente um labirinto por uma matriz de caracteres.
2. Trate o labirinto como um **grafo** (posições livres = vértices, vizinhanças
   ortogonais = arestas).
3. Encontre o **menor caminho** entre a entrada `E` e a saída `S`.
4. Exiba o labirinto original e o resolvido, indicando o caminho com `*`.

## 2. Requisitos funcionais

| ID    | Requisito                                                              |
|-------|------------------------------------------------------------------------|
| RF-01 | Armazenar o labirinto em uma matriz de caracteres.                     |
| RF-02 | Exibir o labirinto original na tela.                                   |
| RF-03 | Localizar automaticamente a entrada `E`.                              |
| RF-04 | Localizar automaticamente a saída `S`.                               |
| RF-05 | Percorrer apenas caminhos livres, ignorando paredes `#`.              |
| RF-06 | Encontrar o menor caminho entre `E` e `S`.                           |
| RF-07 | Marcar o caminho encontrado com o caractere `*`.                      |
| RF-08 | Exibir o labirinto resolvido.                                         |
| RF-09 | Informar a quantidade de passos do caminho.                          |
| RF-10 | Informar claramente quando não existir caminho.                       |

## 3. Requisitos de implementação (obrigatórios)

| ID    | Requisito                                                              |
|-------|------------------------------------------------------------------------|
| RI-01 | Uso de matriz de caracteres para o labirinto.                         |
| RI-02 | Função para exibir o labirinto.                                       |
| RI-03 | Função para localizar a entrada.                                      |
| RI-04 | Função para localizar a saída.                                        |
| RI-05 | `struct` representando uma posição (linha e coluna).                  |
| RI-06 | Controle de posições visitadas.                                      |
| RI-07 | Registro do caminho percorrido (reconstrução do caminho).            |
| RI-08 | Algoritmo de busca para o menor caminho.                             |
| RI-09 | Impressão do labirinto resolvido.                                    |
| RI-10 | Contagem da quantidade de passos.                                    |

## 4. Requisitos técnicos

- Desenvolvido em **C ANSI (C89)**.
- Usar `#include <stdio.h>` e `#include <stdlib.h>`.
- Possuir `int main(void)`.
- Código indentado, nomes de variáveis compreensíveis, funções organizadas.
- Compilar e executar corretamente sem alterações no ambiente de aula.

## 5. Restrições (núcleo)

- Apenas movimentos ortogonais (cima, baixo, esquerda, direita). **Sem diagonais.**
- O **núcleo** (`labirinto.c`) usa apenas bibliotecas ANSI (`stdio.h`; o
  programa também usa `stdlib.h` e os testes usam `assert.h`).
- Deve permitir trocar o labirinto facilmente (testar outro labirinto).

## 6. Funcionalidades adicionais (extras, fora do núcleo ANSI)

Recursos didáticos implementados **além** do exigido. Ficam isolados em
`visualizacao.c` (usa `windows.h`, portanto não-ANSI) e são **opcionais**:

| ID    | Funcionalidade extra                                              |
|-------|-------------------------------------------------------------------|
| EX-01 | Segundo algoritmo de busca: **Dijkstra** (comparação com a BFS).  |
| EX-02 | **Animação** da exploração da busca, passo a passo.               |
| EX-03 | **Áudio** durante a animação (em *thread* paralela).              |
| EX-04 | Menu com escolha de algoritmo e de modo (com/sem áudio/estático). |
| EX-05 | **Testes automatizados** do núcleo (`testes.c`).                  |

## 7. Critérios de aceitação

- [ ] Núcleo compila com `gcc -ansi -pedantic -Wall labirinto.c testes.c` sem avisos.
- [ ] Programa completo compila com `build.bat`.
- [ ] `testes.exe` passa em todos os testes.
- [ ] Exibe labirinto original e resolvido.
- [ ] Encontra o menor caminho (verificado por contagem de passos) — BFS e Dijkstra.
- [ ] Trata corretamente o caso "não existe caminho".
- [ ] Funciona ao substituir o labirinto por outro maior/diferente.
