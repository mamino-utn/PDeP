mago(harry,mestiza,[coraje,amistoso,orgulloso,inteligente]).
mago(draco,pura,[inteligente,orgulloso]).
mago(hermione,impura,[inteligente,orgulloso,responsable]).

odiariaIr(harry,slytherin).
odiariaIr(draco,hufflepuff).

casa(gryffindor).
casa(slytherin).
casa(revenclaw).
casa(hufflepuff).

caracterEnCuenta(gryffindor,[coraje]).
caracterEnCuenta(slytherin,[orgulloso,inteligente]).
caracterEnCuenta(revenclaw,[inteligente,responsable]).
caracterEnCuenta(hufflepuff,[amistoso]).

% Punto 1

lePermiteEntrar(Casa,_):- 
    casa(Casa),
    Casa \=slytherin.

lePermiteEntrar(slytherin,Mago):- mago(Mago,Sangre,_), Sangre \= impura.

% Punto 2
caracterApropiado(Mago,Casa):- casa(Casa), mago(Mago,_,CaracteristicasMago),caracterEnCuenta(Casa,CaracteristicasApropiadas),
    forall(member(Caracter,CaracteristicasApropiadas),member(Caracter,CaracteristicasMago)).

% Punto 3

podriaQuedarEn(Casa,Mago):- 
    caracterApropiado(Mago,Casa),
    lePermiteEntrar(Casa,Mago),
    not(odiariaIr(Mago,Casa)).
podriaQuedarEn(gryffindor,hermione).

% Punto 4

cadenaDeAmistades(Magos):-
    forall((member(Mago,Magos),mago(Mago,_,CaracteristicasMago)), member(amistoso,CaracteristicasMago)),
    mismaCasa(Magos).

mismaCasa([]).
mismaCasa([Mago,Mago2 | Magos]):- mago(Mago,_,_),casa(Casa),
    podriaQuedarEn(Casa,Mago),
    podriaQuedarEn(Casa,Mago2),
    mismaCasa([Mago2 | Magos]).
mismaCasa([_ | Magos]):- mismaCasa([Magos]).

% --------- Parte 2 ----------


queHizo(harry,estuvoFueraDeCama).
queHizo(harry,irA(elBosque)).
queHizo(harry,irA(elTercerPiso)).
queHizo(harry,derrotoAVoldemort).

queHizo(draco,irA(lasMazmorras)).

queHizo(ron,ganoEnAjedresMagico).

queHizo(hermione,salvoASusAmigos).
queHizo(hermione,irA(elTercerPiso)).
queHizo(hermione,irA(seccionRestringidaBiblioteca)).

lugarProhibido(elBosque).
lugarProhibido(seccionRestringidaBiblioteca).
lugarProhibido(elTercerPiso).

puntaje(estuvoFueraDeCama,-50).
puntaje(irA(elBosque),-50).
puntaje(irA(elTercerPiso),-75).
puntaje(irA(seccionRestringidaBiblioteca),-10).

puntaje(derrotoAVoldemort,60).
puntaje(salvoASusAmigos,50).
puntaje(ganoEnAjedresMagico,50).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

% Punto 1
% A
buenAlumno(Mago):-  queHizo(Mago,_),
    forall(queHizo(Mago,Accion),not(esMalaAccion(Accion))).

esMalaAccion(Accion):- puntaje(Accion,Puntaje), Puntaje<0.

% B
accionRecurrente(Accion):- 
    queHizo(Mago,Accion),
    queHizo(Mago2,Accion),
    Mago \= Mago2.

% Punto 2 

puntajeTotalCasa(Casa,PuntajeTotal):- distinct(Casa,esDe(_,Casa)),
    findall(Puntaje,(esDe(Mago,Casa),queHizo(Mago,Accion),puntaje(Accion,Puntaje)),Puntajes),
    sum_list(Puntajes,PuntajeTotal).
    


