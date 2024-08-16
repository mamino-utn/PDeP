% La solución va acá. Éxitos!

/* 
	Decidi agregar a la base de conocimientos como hechos que instrumentos sabe tocar cada persona 
	porque por enunciado sabemos que su valor de verdad es verdadero 
	y por principio de unvierso cerrado todo dato conocido por la base de conocimiento siempre es verdadero
*/

toca(charly,teclado).
toca(charly,piano).

toca(ricardo,guitarra).

toca(eduardo,guitarra).
toca(eduardo,bajo).
toca(eduardo,bateria).
toca(eduardo,teclado).

toca(rodolfo,teclado).
toca(rodolfo,piano).

/* Corrección Profesor
toca(rodolfo,Instrumento):- toca(charly,Instrumento).
*/
toca(jose,guitarra).
toca(jose,bajo).
toca(jose,bateria).

toca(armando,pandereta).
toca(armando,bateria).

/*
	En cambio a Mauricio no es necesario agregarlo
	porque por principio de universo cerrado todo lo que no es conocido por la base de conocimiento es falso
	Tampoco agrego que le gusta escuchar musica porque no tiene relevancia en la resolucion de los ejercicios posteriores
*/

/* 
	Defino una regla que me diga quines son las persona que saben tocar guitarra y bateria
	utilizo una regla con un and logico que me unifique una persona y pregunte si esa persona toca la guitarra y el bajo
*/
groso(Persona):- toca(Persona,guitarra),toca(Persona,bateria).

/*
	Definimos una nueva regla que unifica los instrumentos que tocan dos personas distintas
	Si tocan el mismo instrumento pueden ser un duo
*/
duo(Persona,OtraPersona):-
	toca(Persona,Instrumento),
	toca(OtraPersona,Instrumento),
	OtraPersona \= Persona .



:- begin_tests(template).

test(una_persona_es_grosa,set(Persona=[eduardo,jose])):- 
	groso(Persona).

test(una_persona_no_es_grosa,fail):-
	groso(charly).

test(dos_personas_son_un_duo,nondet):-
	duo(charly,eduardo).

test(dos_personas_no_son_un_duo,fail):-
	duo(charly,armando).

test(fake_test) :-
	3 is 2 + 1.

:- end_tests(template).