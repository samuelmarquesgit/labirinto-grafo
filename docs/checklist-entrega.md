# Checklist de Entrega — Conferência dos Requisitos

Documento de conferência: cada exigência do enunciado → **onde exatamente** está
cumprida no código. Use isto antes de entregar e para se preparar para o teste
de autoria.

> Legenda: ✅ pronto no código · 📝 ação manual sua (preencher/anexar)

---

## A) Requisitos do código ("O código deverá conter")

| # | Requisito | Status | Onde está (arquivo : função / linha) |
|---|-----------|:------:|--------------------------------------|
| 1 | Matriz de caracteres p/ armazenar o labirinto | ✅ | `labirinto.h` → `char grade[MAX_LINHAS][MAX_COLUNAS]` na `struct Labirinto`; preenchida em `labirinto.c:34` (`carregarDoVetor`) |
| 2 | Função para exibir o labirinto | ✅ | `labirinto.c:47` → `exibirLabirinto()` |
| 3 | Função para localizar a entrada | ✅ | `labirinto.c:58` → `localizar(lab, 'E')` (chamada em `resolverLabirinto`) |
| 4 | Função para localizar a saída | ✅ | `labirinto.c:58` → `localizar(lab, 'S')` |
| 5 | Struct com linha e coluna | ✅ | `labirinto.h` → `typedef struct { int linha; int coluna; } Posicao;` |
| 6 | Controle de posições visitadas | ✅ | `labirinto.c:106,135,140,164` → matriz `visitado` |
| 7 | Registro do caminho (reconstrução) | ✅ | `labirinto.c:107,165,185` → matriz `pai`; reconstrução em `labirinto.c:182-192` |
| 8 | Algoritmo de busca p/ menor caminho | ✅ | `labirinto.c` → `resolverLabirinto()` (BFS) **e** `resolverDijkstra()` (Dijkstra) |
| 9 | Impressão do labirinto resolvido | ✅ | `main.c:60,62` → `marcarCaminho()` + `exibirLabirinto()` |
| 10 | Contagem da quantidade de passos | ✅ | `labirinto.c:195` → `res->passos = qtd - 1` (exibido em `main.c`) |

---

## B) Requisitos técnicos ("O programa deverá")

| Requisito | Status | Observação |
|-----------|:------:|-----------|
| Ser desenvolvido em C ANSI | ✅ | Núcleo (`labirinto.c`) compila com `-ansi -pedantic`. Comentários `/* */`, variáveis no início dos blocos. ⚠️ Ver nota sobre `visualizacao.c` abaixo. |
| Usar `#include <stdio.h>` e `<stdlib.h>` | ✅ | `main.c:11-12`, `labirinto.c:13` |
| Possuir `int main(void)` | ✅ | `main.c:70` |
| Estar indentado | ✅ | Indentação de 4 espaços em todos os arquivos |
| Nomes de variáveis compreensíveis | ✅ | `entrada`, `saida`, `vizinho`, `numLinhas`, `deslocaColuna`... |
| Funções organizadas | ✅ | Separadas por responsabilidade (carregar, exibir, localizar, resolver) |
| Compilar e executar corretamente | ✅* | *Confirme rodando `build.bat` no seu ambiente (ver seção C) |

> ⚠️ **Nota importante sobre C ANSI:** o arquivo `visualizacao.c` (animação +
> áudio) usa `windows.h`, que **não é** C ANSI. Ele é um **extra didático**. O
> requisito de C ANSI é atendido pelo **núcleo** (`labirinto.c` + `main.c` na
> opção estática). Se o professor exigir ANSI estrito no programa todo, você
> pode entregar/demonstrar apenas a parte estática (**opção 5** do menu). Decida
> com a equipe — ver `docs/glossario.md` e o `README.md`.
>
> 💡 As referências de linha (`labirinto.c:NN`) são aproximadas — o arquivo
> cresceu com a inclusão do Dijkstra. Use a busca por nome de função se precisar.

---

## C) Verificação prática (faça antes de entregar)

- [ ] `build.bat` compila sem erros
- [ ] `gcc -ansi -pedantic -Wall labirinto.c testes.c -o testes.exe` compila **sem avisos** (prova de C ANSI)
- [ ] `testes.exe` mostra "TODOS OS TESTES PASSARAM"
- [ ] `labirinto.exe` opção 5 → mostra original e resolvido (estático)
- [ ] `labirinto.exe` opção 2 (BFS) e opção 4 (Dijkstra) → animação com som funciona
- [ ] Conferir que BFS e Dijkstra dão o **mesmo nº de passos**
- [ ] Testar um labirinto **sem solução** (cercar o `S` com `#`)
- [ ] Testar **outro labirinto** (editar o vetor em `carregarPadrao`, `main.c`)

---

## D) Entrega esperada (itens a entregar)

| Item | Status | Onde / o que falta |
|------|:------:|--------------------|
| 1. Código-fonte completo | ✅ | `labirinto.h/.c`, `visualizacao.h/.c`, `main.c`, `testes.c`, `teste-som.c` |
| 2. Arquivo do projeto do compilador | ✅ | `build.bat` (script de compilação). 📝 Se o professor usa uma IDE específica (Dev-C++, Code::Blocks), gere o arquivo de projeto dela também |
| 3a. Nome dos integrantes | 📝 | Preencher em `docs/documento-entrega.md` |
| 3b. Explicação do problema | ✅ | `docs/documento-entrega.md` (seção 2) |
| 3c. Como o labirinto foi representado | ✅ | `docs/documento-entrega.md` (seção 3) |
| 3d. Explicação do algoritmo | ✅ | `docs/documento-entrega.md` (seção 4) + `docs/explicacao-algoritmo.md` |
| 3e. Exemplo de execução | ✅ | `docs/exemplo-execucao.md` |
| 3f. Capturas de tela funcionando | 📝 | Rodar `labirinto.exe`, tirar prints do original e do resolvido, colar em `docs/documento-entrega.md` |

---

## E) Pendências suas (resumo do que falta fazer à mão)

1. 📝 **Preencher os nomes dos integrantes** em `docs/documento-entrega.md`.
2. 📝 **Tirar as capturas de tela** do programa rodando (original + resolvido).
3. 📝 **Rodar `build.bat` e `testes.exe`** para confirmar que tudo compila e passa.
4. 📝 **(Opcional)** Gerar o arquivo de projeto da IDE da aula, se exigido.
5. 📝 **Decidir com a equipe** como apresentar a parte de áudio (extra não-ANSI).

> Tudo que está como ✅ já está pronto no código/documentação. Os 📝 dependem de
> você executar/preencher.
