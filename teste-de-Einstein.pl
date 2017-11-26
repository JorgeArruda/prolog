%________ Jorge de Arruda Martins _________%

% S[_,_,_,_,_]  S[C1,C2,C3,C4,C5] Regras 15

% Retorna todos os possiveis valores
cor([amarela,azul,branca,verde,vermelha]).
nacionalidade([alemao,dinamarques,ingles,noruegues,sueco]).
bebida([agua,cafe,cerveja,cha,leite]).
cigarro([blends,bluemaster,dunhill,pall_mall,prince]).
animal([cachorros,cavalos,gatos,passaros,peixes]).

% Verifica as regras basicas, para as quais se conhece a casa
% Recebe uma lista simples(casa) e verifica se o noruegues encontra-se nessa casa
regra_noruegues([_,noruegues,_,_,_]).
% Recebe uma lista simples(casa) e verifica se o leite encontra-se nessa casa
regra_leite([_,_,leite,_,_]).

% Verifica as regras para pares, para as quais determinadas caracteristicas devem ficar na mesma casa
ingles_vermelha([vermelha,ingles,_,_,_]).
sueco_cachorro([_,sueco,_,_,cachorros]).
dinamarques_cha([_,dinamarques,cha,_,_]).
verde_cafe([verde,_,cafe,_,_]).
pallmall_passaro([_,_,_,pall_mall,passaros]).
amarela_dunhill([amarela,_,_,dunhill,_]).
bluemaster_cerveja([_,_,cerveja,bluemaster,_]).
alemao_prince([_,alemao,_,prince,_]).

% Verifica as regras para vizinhos, para as quais determinadas caracteristicas devem ficar em casas vizinhas(à esquerda ou direita)
verde_branca(MATRIZ):-esquerda([verde,_,_,_,_],[branca,_,_,_,_],MATRIZ).
blends_gatos(MATRIZ):-esquerda([_,_,_,blends,_],[_,_,_,_,gatos],MATRIZ);
                      direita([_,_,_,blends,_],[_,_,_,_,gatos],MATRIZ).
cavalos_dunhill(MATRIZ):-esquerda([_,_,_,_,cavalos],[_,_,_,dunhill,_],MATRIZ);
                      direita([_,_,_,_,cavalos],[_,_,_,dunhill,_],MATRIZ).
noruegues_azul(MATRIZ):-esquerda([_,noruegues,_,_,_],[azul,_,_,_,_],MATRIZ);
                      direita([_,noruegues,_,_,_],[azul,_,_,_,_],MATRIZ).
blends_agua(MATRIZ):-esquerda([_,_,_,blends,_],[_,_,agua,_,_],MATRIZ);
                      direita([_,_,_,blends,_],[_,_,agua,_,_],MATRIZ).


% Verifica se a lista ESQUERDA encontra-se à esquerda da lista VIZINHO
% na lista composta [HEAD|TAIL], a lista de casas
esquerda(ESQUERDA,VIZINHO,[ESQUERDA,VIZINHO|_]).
esquerda(ESQUERDA,VIZINHO,[HEAD|TAIL]):-esquerda(ESQUERDA,VIZINHO,TAIL).
% Verifica se a lista DIREITA encontra-se à direita da lista VIZINHO
% na lista composta [HEAD|TAIL], a lista de casas
direita(DIREITA,VIZINHO,[VIZINHO,DIREITA|_]).
direita(DIREITA,VIZINHO,[HEAD|TAIL]):-direita(DIREITA,VIZINHO,TAIL).


%_________________________________________________________________________________________
%     Preecher a matriz de casas X valores

% Verifica com select qual termo disponivel em Tipo corresponde a POSICAO
% e retorna a nova lista de termo disponivel(atualizada) em OUTRO
tipo(POSICAO,[POSICAO],[]).
tipo(POSICAO,TIPO,OUTRO):-select(POSICAO, TIPO, OUTRO).

% Preeche os campos [A,B,C,D,E] da casa com o valor correspondente da lista [COR,NAC,BEB,CIG,ANI]
% e retorna os outros valores em RESTA
casa_tipos([A,B,C,D,E],[COR,NAC,BEB,CIG,ANI],RESTA):-
        (tipo(A,COR,OUTRA_COR)),
        (tipo(B,NAC,OUTRA_NACIONALIDADE)),
        (tipo(C,BEB,OUTRA_BEBIDA)),
        (tipo(D,CIG,OUTRO_CIGARRO)),
        (tipo(E,ANI,OUTRO_ANIMAL)),
        RESTA=[OUTRA_COR,OUTRA_NACIONALIDADE,OUTRA_BEBIDA,OUTRO_CIGARRO,OUTRO_ANIMAL].

% Laço de repetição para percorrer a lista de casas [CASA|OUTRAS]
casas_tipos([],VALORES).
casas_tipos([CASA|OUTRAS],VALORES):-
        casa_tipos(CASA,VALORES,ATUALIZADO),
        casas_tipos(OUTRAS,ATUALIZADO).
%_________________________________________________________________________________________

resolver(COLUNA1,COLUNA2,COLUNA3,COLUNA4,COLUNA5):-
    cor(COR),nacionalidade(NACIONALIDADE),
    bebida(BEBIDA),cigarro(CIGARRO),animal(ANIMAL),
    VALORES=[COR,NACIONALIDADE,BEBIDA,CIGARRO,ANIMAL],
    % Atribui um vetor tamanho 5 de variaveis para armazenar as caracteristicas de cada casa
    COLUNA1=[CASA1x1,CASA2x1,CASA3x1,CASA4x1,CASA5x1],
    COLUNA2=[CASA1x2,CASA2x2,CASA3x2,CASA4x2,CASA5x2],
    COLUNA3=[CASA1x3,CASA2x3,CASA3x3,CASA4x3,CASA5x3],
    COLUNA4=[CASA1x4,CASA2x4,CASA3x4,CASA4x4,CASA5x4],
    COLUNA5=[CASA1x5,CASA2x5,CASA3x5,CASA4x5,CASA5x5],
    % Verifica as regras basicas, para as quais se conhece a casa
    regra_noruegues(COLUNA1),
    regra_leite(COLUNA3),
    % Verifica as regras para pares, para as quais determinadas caracteristicas devem ficar na mesma casa
    ((ingles_vermelha(COLUNA1);   ingles_vermelha(COLUNA2);     ingles_vermelha(COLUNA3);    ingles_vermelha(COLUNA4);
          ingles_vermelha(COLUNA5)),
    (sueco_cachorro(COLUNA1);     sueco_cachorro(COLUNA2);      sueco_cachorro(COLUNA3);     sueco_cachorro(COLUNA4);
          sueco_cachorro(COLUNA5)),
    (dinamarques_cha(COLUNA1);    dinamarques_cha(COLUNA2);     dinamarques_cha(COLUNA3);    dinamarques_cha(COLUNA4);
          dinamarques_cha(COLUNA5)),
    (verde_cafe(COLUNA1);         verde_cafe(COLUNA2);          verde_cafe(COLUNA3);         verde_cafe(COLUNA4);
          verde_cafe(COLUNA5)),
    (pallmall_passaro(COLUNA1);   pallmall_passaro(COLUNA2);    pallmall_passaro(COLUNA3);   pallmall_passaro(COLUNA4);
          pallmall_passaro(COLUNA5)),
    (amarela_dunhill(COLUNA1);    amarela_dunhill(COLUNA2);     amarela_dunhill(COLUNA3);    amarela_dunhill(COLUNA4);
          amarela_dunhill(COLUNA5)),
    (bluemaster_cerveja(COLUNA1); bluemaster_cerveja(COLUNA2);  bluemaster_cerveja(COLUNA3); bluemaster_cerveja(COLUNA4);
          bluemaster_cerveja(COLUNA5)),
    (alemao_prince(COLUNA1);      alemao_prince(COLUNA2);       alemao_prince(COLUNA3);      alemao_prince(COLUNA4);
          alemao_prince(COLUNA5))),
    % Verifica as regras para vizinhos, para as quais determinadas caracteristicas devem ficar em casas vizinhas
    verde_branca([COLUNA1,COLUNA2,COLUNA3,COLUNA4,COLUNA5]),
    blends_gatos([COLUNA1,COLUNA2,COLUNA3,COLUNA4,COLUNA5]),
    cavalos_dunhill([COLUNA1,COLUNA2,COLUNA3,COLUNA4,COLUNA5]),
    noruegues_azul([COLUNA1,COLUNA2,COLUNA3,COLUNA4,COLUNA5]),
    blends_agua([COLUNA1,COLUNA2,COLUNA3,COLUNA4,COLUNA5]),
    % Preeche cada campo do vetor de casas com valores, respeitando a regra de não repetir atributos
    casas_tipos([COLUNA1,COLUNA2,COLUNA3,COLUNA4,COLUNA5],VALORES).
