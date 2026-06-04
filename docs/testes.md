# Testes Automatizados

Como o projeto é testado para **não ser entregue quebrado** — o papel que o
`pytest` tem em Python, aqui é feito com `assert.h` (parte do próprio C ANSI).

## Como rodar

No Windows, dentro da pasta do projeto:

```bat
run-tests.bat
```

Ou manualmente:

```bat
gcc -ansi -pedantic -Wall labirinto.c testes.c -o testes.exe
testes.exe
```

## Como funciona

- O arquivo [`../testes.c`](../testes.c) é um **executável separado** do programa
  (tem seu próprio `main`). Ele **não faz parte da entrega** — é só a sua
  ferramenta de garantia.
- Cada verificação usa `assert(condição)`:
  - se a condição for **verdadeira**, o teste segue;
  - se for **falsa**, o programa **aborta** e mostra o arquivo e a linha do erro.
- Os testes usam **labirintos pequenos** com resultado conhecido, então é fácil
  conferir se a busca está correta.
- Importante: `testes.c` só compila com `labirinto.c` (o núcleo ANSI). Ele **não**
  usa `visualizacao.c`, porque os testes checam apenas a **lógica**, não o som.

## O que é testado

| Teste                       | Verifica                                            |
|-----------------------------|-----------------------------------------------------|
| `teste_carregar`            | Dimensões e conteúdo da matriz carregada.           |
| `teste_localizar`           | Acha `E` e `S`; devolve -1 quando não existe.        |
| `teste_ehLivre`             | Paredes e limites são tratados corretamente.         |
| `teste_caminho`             | BFS acha o **menor** caminho (passos e tamanho).     |
| `teste_sem_caminho`         | BFS detecta quando **não há** caminho.               |
| `teste_marcar`              | Marca o caminho com `*` sem apagar `E` e `S`.        |
| `teste_dijkstra`            | Dijkstra acha o **mesmo** menor caminho que a BFS.   |
| `teste_dijkstra_sem_caminho`| Dijkstra também detecta ausência de caminho.         |

## Saída esperada

```
Iniciando testes...

OK - carregar e dimensoes
OK - localizar entrada/saida
OK - ehLivre (limites e paredes)
OK - menor caminho (passos = 6)
OK - detecta ausencia de caminho
OK - marcar caminho preserva E e S
OK - Dijkstra (passos = 6, igual a BFS)
OK - Dijkstra detecta ausencia de caminho

========================================
 TODOS OS TESTES PASSARAM COM SUCESSO!
========================================
```

Se algum teste falhar, em vez disso aparece algo como:

```
Assertion failed: res.passos == 6, file testes.c, line 95
```

indicando exatamente onde está o problema.

## Dica para a apresentação

Rode `run-tests.bat` **antes** do teste de autoria. Se tudo passar, você tem
confiança de que o algoritmo está correto e não vai ser pego por um bug na hora.
