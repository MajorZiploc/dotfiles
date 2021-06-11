:- initialization main, halt; halt.

/**
 * list membership check function
 */
mem(X, [X|_]).
mem(X, [_|XS]) :- mem(X,XS).

woman(mia).
woman(jody).
woman(yolanda).

vertical(line(point(X,Y), point(X,Z))).
horizontal(line(point(X,Y), point(Z,Y))).

word(astante,  a,s,t,a,n,t,e).
word(astoria,  a,s,t,o,r,i,a).
word(baratto,  b,a,r,a,t,t,o).
word(cobalto,  c,o,b,a,l,t,o).
word(pistola,  p,i,s,t,o,l,a).
word(statale,  s,t,a,t,a,l,e).

crossword(
  word(VW1, _, V1H1, _, V1H2, _, V1H3, _),
  word(VW2, _, V2H1, _, V2H2, _, V2H3, _),
  word(VW3, _, V3H1, _, V3H2, _, V3H3, _),
  word(HW1, _, V1H1, _, V2H1, _, V3H1, _),
  word(HW2, _, V1H2, _, V2H2, _, V3H2, _),
  word(HW3, _, V1H3, _, V2H3, _, V3H3, _)
).

crossword_prac :-
  crossword(
  word(astante,  a,s,t,a,n,t,e),
  word(baratto,  b,a,r,a,t,t,o),
  word(pistola,  p,i,s,t,o,l,a),
  A,
  B,
  C
  )
  , write([A,B,C]), nl
  , write("pass"), nl
  .

uni_prac :-
  bread = 'bread',
  write("pass"), nl.

mem_line :-
  member(X, [red, blue])
  , write(X), nl
  /** findall will fill all solutions to the predicate and store in WS*/
  , findall(W, woman(W), WS)
  , write(WS), nl
  , mem(W0, WS), horizontal(line(point(1, W0), point(4, jody)))
  , write(W0), nl
  , vertical(line(P, point(1, Z)))
  , write(P), nl
  , nl.

main :- crossword_prac.

