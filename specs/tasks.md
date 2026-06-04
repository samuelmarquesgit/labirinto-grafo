# Tarefas — Labirinto com Grafos

Lista de tarefas de implementação, mapeadas aos requisitos
([`requirements.md`](requirements.md)).

## Implementação (núcleo) — concluída

- [x] `struct Posicao` (linha, coluna) — RI-05
- [x] `struct Labirinto` (grade + dimensões) — RI-01
- [x] `carregarDoVetor()` — montar o labirinto na memória
- [x] `exibirLabirinto()` — exibir a matriz — RF-02 / RI-02
- [x] `localizar('E')` — achar a entrada — RF-03 / RI-03
- [x] `localizar('S')` — achar a saída — RF-04 / RI-04
- [x] `ehLivre()` — validar limites e ignorar paredes — RF-05
- [x] Vetores de deslocamento (4 direções, sem diagonal)
- [x] Controle de visitados — RI-06
- [x] `resolverLabirinto()` — BFS para o menor caminho — RF-06 / RI-08
- [x] Matriz `pai` + reconstrução do caminho — RI-07
- [x] `marcarCaminho()` — marcar caminho com `*` — RF-07
- [x] Exibir labirinto resolvido — RF-08 / RI-09
- [x] Contar e exibir passos — RF-09 / RI-10
- [x] Mensagem para "não existe caminho" — RF-10
- [x] `int main(void)` + `stdio.h`/`stdlib.h` — req. técnicos

## Extras — concluídos

- [x] `resolverDijkstra()` — segundo algoritmo — EX-01
- [x] `animarBusca()` — animação passo a passo — EX-02
- [x] `bipAssincrono()` — áudio em *thread* — EX-03
- [x] Menu com 6 opções (BFS/Dijkstra, com/sem áudio, estático) — EX-04
- [x] `testes.c` — bateria de testes com `assert` — EX-05
- [x] `teste-som.c` — diagnóstico isolado do áudio

## Verificação — fazer antes de entregar

- [ ] `gcc -ansi -pedantic -Wall labirinto.c testes.c -o testes.exe` sem avisos
- [ ] `build.bat` compila programa + testes
- [ ] `testes.exe` → "TODOS OS TESTES PASSARAM"
- [ ] Opção 5 (estático): confere caminho e passos
- [ ] Opção 2/4 (animado + áudio): confere animação e som
- [ ] Testar labirinto **sem solução** (fechar a saída com `#`)
- [ ] Testar **outro labirinto** (maior/diferente)
- [ ] Testar borda: `E` ou `S` ausente

## Documentação e entrega

- [x] README do projeto (atualizado)
- [x] Especificação (requisitos, design, tarefas)
- [x] Diretrizes (steering)
- [x] Guia de apresentação + checklist de entrega
- [x] Roteiro de vídeo + explicação do algoritmo + glossário
- [x] Documento de entrega (modelo) — **falta preencher integrantes**
- [ ] Nomes dos integrantes em `docs/documento-entrega.md`
- [ ] Capturas de tela do programa funcionando
- [ ] Revisão final antes de 25/06/2026

## Ideias de evolução (opcionais, não implementadas)

- [ ] Ler o labirinto de um arquivo `.txt` em vez de embutido no código
- [ ] Permitir escolher entre vários labirintos no menu
- [ ] Dijkstra com fila de prioridade (heap) em vez de seleção linear
