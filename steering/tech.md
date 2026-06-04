# Steering — Técnica

Diretrizes sobre **como** o projeto é construído.

## Linguagem e padrão

- **Núcleo em C ANSI (C89/C90).** `labirinto.c`, `labirinto.h`, `main.c` e
  `testes.c` seguem o padrão e compilam com `-ansi -pedantic`.
- Regras de C89 que o código segue:
  - Comentários apenas no formato `/* ... */` (não usar `//`).
  - Variáveis declaradas **no início** de cada bloco, antes de qualquer comando.
  - `int main(void)` com retorno explícito.
- **Exceção isolada:** `visualizacao.c` usa `windows.h` (não é ANSI) para som e
  animação. É compilado **sem** `-ansi`. Ver tabela de decisões.

## Bibliotecas usadas

| Biblioteca     | Onde            | É ANSI? |
|----------------|-----------------|:-------:|
| `stdio.h`      | todo o projeto  | ✅ |
| `stdlib.h`     | `main.c`, `visualizacao.c` | ✅ |
| `assert.h`     | `testes.c`      | ✅ |
| `windows.h`    | `visualizacao.c` (Beep, Sleep, threads, console) | ❌ |

## Compilação

```bat
:: Programa completo (com animacao + audio): SEM -ansi por causa do windows.h
gcc -Wall labirinto.c visualizacao.c main.c -o labirinto.exe

:: Nucleo + testes: C ANSI puro
gcc -ansi -pedantic -Wall labirinto.c testes.c -o testes.exe
```

Ou simplesmente rode **`build.bat`** (faz as duas compilações).

- `-ansi` → força o padrão C89.
- `-pedantic` → acusa extensões fora do padrão.
- `-Wall` → liga todos os avisos comuns.

**Meta:** o build dos testes (C ANSI) deve compilar sem **nenhum** aviso — é a
prova de que o núcleo está dentro da norma.

## Convenções de código

- **Nomes em português**, descritivos: `resolverLabirinto`, `numLinhas`,
  `deslocaColuna`, `bipAssincrono`.
- **Funções pequenas e com responsabilidade única**: carregar, exibir,
  localizar, validar, resolver, animar.
- **Indentação** de 4 espaços.
- **Comentários didáticos** explicando o *porquê*, não só o *o quê* — o código é
  material de estudo para o teste de autoria.

## Decisões técnicas

| Decisão                          | Justificativa                                          |
|----------------------------------|--------------------------------------------------------|
| BFS como algoritmo principal     | Pesos iguais a 1 → BFS já dá o menor caminho, e é simples. |
| Dijkstra também implementado     | Comparação didática; mesmo resultado com peso 1.       |
| Dijkstra com seleção linear do mínimo | Sem fila de prioridade; simples e suficiente para o tamanho do labirinto (`O(V²)`). |
| Grafo implícito (sem adjacência) | Vizinhos calculados por deslocamento; economiza memória. |
| Matrizes auxiliares `static`     | Evita estouro de pilha em labirintos grandes.          |
| Labirinto embutido em strings    | Simplicidade; fácil de trocar para testar outro.       |
| Áudio em *thread* (`CreateThread`) | `Beep` é bloqueante; a thread evita travar a animação. |
| Cursor reposicionado (sem `cls` por quadro) | Evita abrir `cmd.exe` a cada quadro (piscar/áudio cortado). |

## Limites configuráveis

```c
#define MAX_LINHAS  100   /* labirinto.h */
#define MAX_COLUNAS 200
#define INTERVALO_SOM 3   /* visualizacao.c: emite som a cada N nos */
```

Aumente `MAX_*` caso use um labirinto maior.

## Áudio: regra de ouro

O `Beep` precisa de duração suficiente (~80 ms+) para tocar limpo, e o
espaçamento entre bips deve ser **≥** a duração da nota, senão as threads de som
se atropelam. Veja `visualizacao.c` e `docs/explicacao-algoritmo.md`.

## Verificação antes de apresentar

1. Rodar `build.bat` — programa e testes compilam.
2. Rodar `testes.exe` — todos os testes passam.
3. Rodar `labirinto.exe`, opção 5 (estático) — confere o caminho e os passos.
4. Rodar opção 2/4 (animado com áudio) — confere a animação e o som.
5. Testar um labirinto **sem solução** e um **diferente** (editar `carregarPadrao`).
