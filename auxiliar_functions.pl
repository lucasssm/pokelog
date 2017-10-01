membro(X,[X|_]).
membro(X,[_|Y]):- membro(X,Y).

getpokemonlist(L) :- findall(X, pokemon(_,X, _, _, _, _, _, _, _), L).

ispokemon(X):-
  getpokemonlist(List),
  membro(X, List).


ifThenElse(X,Y,_):- X,!,Y.
ifThenElse(_,_,Z):- Z.

setPlayer(Name) :-
    random_between(0,1000, X),
    random_between(0,1000, Y),
    assert( player(Name, position(X,Y)) ).

setEnemiesPosition() :-
    clearBase(enemyPokemon(_, _)), %cleaning enemies setted before
    foreach(between(1,10,_), singleEnemyPosition()).


singleEnemyPosition() :-
    random_between(0,1000, X), %getting random X axis
    random_between(0,1000, Y), %getting random Y axis
    random_between(0, 598, Z), %getting random Pokemon
    findall(pokemon(A,B,C,D,E,F,G,H,I), pokemon(A, B, C, D, E, F, G, H, I), Lista), %getting pokemon list
    nth1(Z, Lista, ChosenOne), %getting one element in the list | Element = Z = Random Pokemon
    assert(enemyPokemon(ChosenOne, position(X,Y))). %asserting enemyPokemon in the map

scanEnemies() :-
    findall((Pokemon, Position), enemyPokemon(Pokemon, Position), Enemies),
    foreach(membro((Pokemon, position(X,Y)), Enemies), checkEnemyProximity(X,Y)).


checkEnemyProximity(X,Y) :-
    %TODO: Implement here the distance comparison
    write('X = '), write(X),
    nl,
    write('Y = '), write(Y),
    nl.
    %nth1(1, Position, Z),
    %write(Z).