Labirinto com Grafos

1. Informações importantes

1.	Este trabalho corresponde à avaliação N3 da disciplina de Estrutura de Dados.
2.	O trabalho poderá ser desenvolvido individualmente ou em equipe de até 3 (três) integrantes.
3.	O prazo para desenvolvimento será de aproximadamente 4 semanas.
4.	A entrega deverá ser realizada até o dia 25/06/2026.
5.	Toda a presença referente a esta etapa da disciplina estará vinculada à participação e entrega do trabalho.
6.	O projeto deverá ser desenvolvido obrigatoriamente em C ANSI básico.
7.	Não serão aceitos trabalhos desenvolvidos em outra linguagem de programação.
8.	O programa deverá executar em modo console, utilizando caracteres para representar o labirinto.
9.	A avaliação será realizada por meio de teste de autoria, com apresentação prática do algoritmo funcionando.
10.	A simples entrega do código-fonte não garante nota.
11.	Programas que não compilam ou não executam não serão aceitos para apresentação.

2. Contexto do problema

Em diversos sistemas computacionais existe a necessidade de encontrar um caminho entre dois pontos. Essa situação aparece em aplicativos de navegação, robôs autônomos, jogos digitais, sistemas de logística e simulações de deslocamento.
Um exemplo didático para esse tipo de problema é o labirinto. Em um labirinto, existe uma entrada, uma saída, caminhos livres e paredes. O objetivo é encontrar uma rota possível entre a entrada e a saída, evitando os obstáculos.
Neste trabalho, o labirinto deverá ser tratado como uma aplicação prática de grafos. Cada posição livre do labirinto será considerada um vértice. Duas posições livres vizinhas, acima, abaixo, à esquerda ou à direita, serão consideradas conectadas por uma aresta. As paredes não fazem parte do caminho, pois representam posições bloqueadas.

3. Objetivo do trabalho

Desenvolver um programa em C ANSI capaz de representar um labirinto em modo caractere e encontrar o menor caminho entre a entrada e a saída.
O programa deverá identificar se existe caminho possível e, caso exista, deverá exibir o caminho encontrado dentro do próprio labirinto.

4. Representação do labirinto

O labirinto deverá ser representado por uma matriz de caracteres.
Cada caractere terá um significado:
•	# representa parede;
•	. ou espaço em branco representa caminho livre;
•	E representa a entrada do labirinto;
•	S representa a saída do labirinto;
•	representa o caminho encontrado pelo algoritmo.

Exemplo de labirinto:


#################################################
E.....#...........#.................#...........#
#.###.#.#.#######.#.#####.#########.#.#####.###.#
#...#.#.#.......#.#.....#.....#.....#.....#...#.#
###.#.#.#######.#.#####.#####.#.#########.###.#.#
#...#.#.......#.....#...#.....#.......#.....#...#
#.###.#######.#######.###.###########.#.#####.###
#.....#.....#.......#...#.....#.......#.....#...#
#####.#.###.#######.###.###.#.#.###########.###.#
#.....#...#.......#.....#...#.#.....#.......#...#
#.#######.#######.#######.###.#####.#.#######.#.#
#.......#.....#.........#...#.....#.#.......#.#.#
#######.#####.#.#######.###.#####.#.#######.#.#.#
#.....#.....#.#.....#...#.......#.#.....#...#.#.#
#.###.#####.#.###.#.#.#########.#.#####.#.###.#.#
#...#.......#.....#.#.........#.#.......#.....#.#
###.###############.#########.#.###############.#
#.................#.........#.#.................#
#.#########################.#.#################.#
#...........................#...................S
#################################################


O exemplo acima é apenas um modelo. Cada equipe poderá criar o seu próprio labirinto, desde que ele seja maior que um exemplo básico e permita testar a busca pelo menor caminho.

5. O que o programa deverá fazer

O programa deverá:
1.	Armazenar o labirinto em uma matriz de caracteres.
2.	Exibir o labirinto original na tela.
3.	Localizar automaticamente a posição da entrada E.
4.	Localizar automaticamente a posição da saída S.
5.	Percorrer o labirinto considerando apenas os caminhos livres.
6.	Ignorar as paredes representadas por #.
7.	Encontrar o menor caminho entre E e S.
8.	Marcar o caminho encontrado usando o caractere *.
9.	Exibir o labirinto resolvido.
10.	Informar a quantidade de passos do caminho encontrado.
11.	Informar claramente caso não exista caminho entre a entrada e a saída.

6. Modelagem como grafo

Embora o labirinto seja exibido como uma matriz de caracteres, ele deverá ser entendido como um grafo.
Nesta modelagem:
•	cada posição livre do labirinto é um vértice;
•	a entrada E também é um vértice;
•	a saída S também é um vértice;
•	cada movimento possível entre duas posições vizinhas é uma aresta;
•	as paredes não são vértices;
•	os movimentos válidos são apenas nas quatro direções:
o	cima;
o	baixo;
o	esquerda;
o	direita.
Movimentos diagonais não serão considerados.

7. Algoritmo de busca

A equipe deverá implementar um algoritmo capaz de encontrar o menor caminho entre a entrada e a saída do labirinto.
Poderá ser utilizada uma das seguintes abordagens:

1.	Busca em Largura (BFS)
Indicada para labirintos sem pesos diferentes entre os movimentos. Como cada deslocamento possui custo 1, a BFS garante o menor caminho em número de passos.

2.	Algoritmo de Dijkstra
Também pode ser utilizado, considerando que cada movimento possui peso 1.
Durante o teste de autoria, a equipe deverá saber justificar a escolha realizada.

8. Resultado esperado

O programa deverá exibir o labirinto original e, depois, o labirinto resolvido.
Exemplo de saída:


#################################################
E.....#...........#.................#...........#
#.###.#.#.#######.#.#####.#########.#.#####.###.#
#...#.#.#.......#.#.....#.....#.....#.....#...#.#
###.#.#.#######.#.#####.#####.#.#########.###.#.#
#...#.#.......#.....#...#.....#.......#.....#...#
#.###.#######.#######.###.###########.#.#####.###
#.....#.....#.......#...#.....#.......#.....#...#
#####.#.###.#######.###.###.#.#.###########.###.#
#.....#...#.......#.....#...#.#.....#.......#...#
#.#######.#######.#######.###.#####.#.#######.#.#
#.......#.....#.........#...#.....#.#.......#.#.#
#######.#####.#.#######.###.#####.#.#######.#.#.#
#.....#.....#.#.....#...#.......#.#.....#...#.#.#
#.###.#####.#.###.#.#.#########.#.#####.#.###.#.#
#...#.......#.....#.#.........#.#.......#.....#.#
###.###############.#########.#.###############.#
#.................#.........#.#.................#
#.#########################.#.#################.#
#...........................#...................S
#################################################


Exemplo de labirinto resolvido:


#################################################
E*****#...........#.................#...........#
#.###*#.#.#######.#.#####.#########.#.#####.###.#
#...#*#.#.......#.#.....#.....#.....#.....#...#.#
###.#*#.#######.#.#####.#####.#.#########.###.#.#
#...#*********#.....#...#.....#.......#.....#...#
#.###.#######*#######.###.###########.#.#####.###
#.....#.....#*******#...#.....#.......#.....#...#
#####.#.###.#######*###.###.#.#.###########.###.#
#.....#...#.......#*****#...#.#.....#.......#...#
#.#######.#######.#####*#.###.#####.#.#######.#.#
#.......#.....#........*#...#.....#.#.......#.#.#
#######.#####.#.#######*###.#####.#.#######.#.#.#
#.....#.....#.#.....#***#.......#.#.....#...#.#.#
#.###.#####.#.###.#.#*#########.#.#####.#.###.#.#
#...#.......#.....#.#*********#.#.......#.....#.#
###.###############.#########*#.###############.#
#.................#.........#*#.................#
#.#########################.#*#################.#
#...........................#*******************S
#################################################


9. Requisitos obrigatórios de implementação

O código deverá conter:
1.	Uso de matriz de caracteres para armazenar o labirinto.
2.	Uso de função para exibir o labirinto.
3.	Uso de função para localizar a entrada.
4.	Uso de função para localizar a saída.
5.	Uso de estrutura para representar uma posição do labirinto, contendo linha e coluna.
6.	Controle de posições visitadas.
7.	Registro do caminho percorrido, permitindo reconstruir o caminho final.
8.	Algoritmo de busca para encontrar o menor caminho.
9.	Impressão do labirinto resolvido.
10.	Contagem da quantidade de passos.

10. Requisitos técnicos

O programa deverá:
•	ser desenvolvido em C ANSI;
•	utilizar #include <stdio.h> e #include <stdlib.h>;
•	possuir int main(void);
•	estar indentado;
•	possuir nomes de variáveis compreensíveis;
•	possuir funções organizadas;
•	compilar e executar corretamente no ambiente utilizado em aula.

11. Entrega

A equipe deverá entregar:
1.	Código-fonte completo.
2.	Arquivo do projeto utilizado no compilador.
3.	Documento simples contendo:
a.	nome dos integrantes;
b.	explicação do problema;
c.	explicação de como o labirinto foi representado;
d.	explicação do algoritmo utilizado;
e.	exemplo de execução;
f.	capturas de tela do programa funcionando.

12. Teste de autoria

A nota do trabalho será definida exclusivamente pelo teste de autoria.
Durante o teste de autoria, a equipe deverá apresentar o algoritmo funcionando e explicar a solução desenvolvida.
O professor poderá solicitar:
•	execução completa do programa;
•	explicação da matriz do labirinto;
•	explicação de como o labirinto representa um grafo;
•	explicação dos vértices e arestas;
•	explicação do algoritmo de busca utilizado;
•	explicação do controle de posições visitadas;
•	explicação da reconstrução do caminho;
•	alteração simples no labirinto;
•	alteração simples no código;
•	teste com outro labirinto;
•	correção de pequenos problemas durante a apresentação.
•	
13. Regra principal da avaliação

O trabalho somente poderá ser apresentado se o algoritmo estiver funcionando.
Não serão aceitos:
1.	códigos que não compilam;
2.	códigos que não executam;
3.	códigos incompletos;
4.	códigos em outra linguagem de programação;
5.	projetos sem demonstração prática;
6.	apresentações apenas com slides;
7.	programas que apenas imprimem um resultado fixo;
8.	soluções que não permitam testar outro labirinto.
Caso o programa não execute corretamente no momento da apresentação, o trabalho não será considerado válido para o teste de autoria.

14. Participação dos integrantes
Todos os integrantes da equipe deverão participar da apresentação.
O professor poderá fazer perguntas para qualquer integrante da equipe.
Cada aluno deverá demonstrar conhecimento sobre:
•	matriz;
•	funções;
•	struct;
•	grafos;
•	vértices;
•	arestas;
•	controle de visitados;
•	algoritmo de busca;
•	reconstrução do caminho;
•	funcionamento geral do código.
Integrantes que não conseguirem demonstrar conhecimento mínimo sobre o projeto poderão receber nota diferente dos demais integrantes.
15. Observação final

O objetivo deste trabalho é aplicar, de forma prática, os conceitos de Estrutura de Dados estudados durante o semestre.
O labirinto será usado como uma situação-problema para demonstrar como matrizes, funções, estruturas, grafos e algoritmos de busca podem ser utilizados na resolução de problemas reais.
Boa implementação!
