% La solución va acá. Éxitos!

/*
1.Resolver en grupo-
Modelar lo necesario para representar los jugadores, las civilizaciones y las tecnologías,
de la forma más conveniente para resolver los siguientes puntos. Incluir los siguientes ejemplos.
Ana, que juega con los romanos y ya desarrolló las tecnologías de herrería, forja, emplumado y láminas.
Beto, que juega con los incas y ya desarrolló herrería, forja y fundición.
Carola, que juega con los romanos y sólo desarrolló la herrería.
Dimitri, que juega con los romanos y ya desarrolló herrería y fundición.
Elsa no juega esta partida.

*/


% Como elsa no juega no la agregamos a nuestra base de conocimiento por principio de universo cerrado

jugador(ana).
jugador(beto).
jugador(carola).
jugador(dimitri).

civilizacion(romanos).
civilizacion(incas).

tecnologia(herreria).
tecnologia(forja).
tecnologia(laminas).
tecnologia(emplumado).
tecnologia(punzon).
tecnologia(fundicion).
tecnologia(malla).
tecnologia(horno).
tecnologia(placas).
tecnologia(molino).
tecnologia(collera).
tecnologia(arado).

usaCivilizacion(ana,romanos).
usaCivilizacion(beto,incas).
usaCivilizacion(carola,romanos).
usaCivilizacion(dimitri,romanos).

usaTecnologia(ana,herreria).
usaTecnologia(ana,forja).
usaTecnologia(ana,emplumado).
usaTecnologia(ana,laminas).
usaTecnologia(beto,herreria).
usaTecnologia(beto,forja).
usaTecnologia(beto,fundicion).
usaTecnologia(carola,herreria).
usaTecnologia(dimitri,herreria).
usaTecnologia(dimitri,fundicion).





/* -Resolver en grupo- Saber si un jugador es experto en metales, que sucede cuando desarrolló 
las tecnologías de herrería, forja y o bien desarrolló fundición o bien juega con los romanos.
En los ejemplos, Ana y Beto son expertos en metales, pero Carola y Dimitri no.
*/

expertoEnMetales(Jugador):- jugador(Jugador),usaTecnologia(Jugador,forja),usaTecnologia(Jugador,herreria),criterioExpertoEnMetales(Jugador).
criterioExpertoEnMetales(Jugador):- usaTecnologia(Jugador,fundicion).
criterioExpertoEnMetales(Jugador):- usaCivilizacion(Jugador,romanos).



% 3.Integrante 1 - Juan
civilizacionEsPopular(Civilizacion):- civilizacion(Civilizacion), usaCivilizacion(Jugador1,Civilizacion),usaCivilizacion(Jugador2,Civilizacion),Jugador1\=Jugador2.

% 4.Integrante 2 - Matias
alcanceGlobal(Tecnologia):- tecnologia(Tecnologia), 
	forall(jugador(Jugador),usaTecnologia(Jugador,Tecnologia)).

% 5. Integrante 3 - David
civilizacionLider(Civilizacion) :- 
	civilizacion(Civilizacion), 
	forall(usaTecnologia(_, Tecnologia) , (usaCivilizacion(Jugador, Civilizacion), usaTecnologia(Jugador, Tecnologia)) ).
	

% UNIDADES

% Como dimitri no tiene unidades no lo agregamos a nuestra base de conocimiento por principio de universo cerrado

%jinete (caballo o camello).
%piquero (nivel, tiene escudo o no).
%camepon (vida).

usaUnidad(ana,jinete(caballo)).
usaUnidad(ana,piquero(1,conEscudo)).
usaUnidad(ana,piquero(2,sinEscudo)).
usaUnidad(beto,campeon(100)).
usaUnidad(beto,campeon(80)).
usaUnidad(beto,piquero(1,conEscudo)).
usaUnidad(beto,jinete(camello)).
usaUnidad(carola,piquero(3,sinEscudo)).
usaUnidad(carola,piquero(2,conEscudo)).


% 7. Integrante 3 - David

vidaDe(campeon(Vida),Vida).
vidaDe(jinete(camello),80).
vidaDe(jinete(caballo),90).
vidaDe(piquero(1,sinEscudo),50).
vidaDe(piquero(2,sinEscudo),65).
vidaDe(piquero(3,sinEscudo),70).
vidaDe(piquero(Nivel,conEscudo),Vida):- 
	vidaDe(piquero(Nivel,sinEscudo),VidaSinEscudo),
 	Vida is VidaSinEscudo * 1.1.


unidades(Jugador,Unidad):- jugador(Jugador),usaUnidad(Jugador,Unidad).

vidaUnidades(Jugador,Vida):- unidades(Jugador,Unidad),vidaDe(Unidad,Vida).

unidadConMasVida(Jugador,Unidad):- unidades(Jugador,Unidad), vidaDe(Unidad,MaximaVida), forall( vidaUnidades(Jugador,Vidas),MaximaVida>= Vidas).

% 8. Integrante 2 - Matias
/*
esJinete(jinete(_)).
esJineteConCaballo(jinete(caballo)).
esJineteConCamello(jinete(camello)).
esPiquero(piquero(_,_)).
esCampeon(campeon(_)).



ventaja(Unidad1,Unidad2):- esJinete(Unidad1),esCampeon(Unidad2).
%ventaja(Unidad1,Unidad2):- esJinete(Unidad2),esCampeon(Unidad1).

ventaja(Unidad1,Unidad2):- esCampeon(Unidad1),esPiquero(Unidad2).
%ventaja(Unidad1,Unidad2):- esCampeon(Unidad2),esPiquero(Unidad1).

ventaja(Unidad1,Unidad2):- esPiquero(Unidad1),esJinete(Unidad2).
%ventaja(Unidad1,Unidad2,UnidadGanadora):- esPiquero(Unidad2),esJinete(Unidad1),UnidadGanadora=Unidad2.

ventaja(Unidad1,Unidad2):- esJineteConCamello(Unidad1),esJineteConCaballo(Unidad2).
%ventaja(Unidad1,Unidad2,UnidadGanadora):- esJineteConCamello(Unidad2),esJineteConCaballo(Unidad1),UnidadGanadora=Unidad2. 

quienGana(Unidad1,Unidad2,UnidadGanadora):- ventaja(Unidad1,Unidad2),UnidadGanadora=Unidad1.
quienGana(Unidad1,Unidad2,UnidadGanadora):- ventaja(Unidad2,Unidad1),UnidadGanadora=Unidad2.

quienGana(Unidad1,Unidad2,UnidadGanadora):-
	compararVidas(Unidad1,Unidad2,Resultado),
	Resultado>0,UnidadGanadora=Unidad1.

quienGana(Unidad1,Unidad2,UnidadGanadora):- 
	compararVidas(Unidad1,Unidad2,Resultado),
	Resultado<0,UnidadGanadora=Unidad2.

compararVidas(Unidad1,Unidad2,Resultado):-
	vidaDe(Unidad1,Vida1),
	vidaDe(Unidad2,Vida2),
	Resultado=Vida1-Vida2.
*/
mismoTipo(jinete(camello),jinete(camello)).
mismoTipo(jinete(caballo),jinete(caballo)).
mismoTipo(campeon(_),campeon(_)).
mismoTipo(piquero(_,_),piquero(_,_)).

quienGana(jinete(_),campeon(_)).
quienGana(campeon(_),piquero(_,_)).
quienGana(piquero(_,_),jinete(_)).
quienGana(jinete(camello),jinete(caballo)).

quienGana(UnidadGanadora,UnidadPerdedora):- mismoTipo(UnidadGanadora,UnidadPerdedora),
	vidaDe(UnidadGanadora,Vida1),
	vidaDe(UnidadPerdedora,Vida2),
	Vida1>Vida2.

% 9 .Integrante 1 - Juan
sobreviveAsedio(Jugador):- jugador(Jugador),aggregate_all(count, usaUnidad(Jugador, piquero(_,conEscudo)), UsaEscudo),aggregate_all(count, usaUnidad(Jugador, piquero(_,sinEscudo)), NoUsaEscudo),
UsaEscudo>NoUsaEscudo.


% punto 10

requerimientoTecnologia(forja,herreria).
requerimientoTecnologia(fundicion,forja).
requerimientoTecnologia(horno,fundicion).
requerimientoTecnologia(laminas,herreria).
requerimientoTecnologia(malla,laminas).
requerimientoTecnologia(placa,malla).
requerimientoTecnologia(emplumado,herreria).
requerimientoTecnologia(punzon,emplumado).
requerimientoTecnologia(collera,molino).
requerimientoTecnologia(arado,collera).
requerimientoTecnologia(herreria,base).
requerimientoTecnologia(molino,base).

puedeDesarrollarTecnologia(Tecnologia,Jugador):- tecnologia(Tecnologia),jugador(Jugador),requerimientoTecnologia(Tecnologia,TecnologiaRequerida),not(usaTecnologia(Jugador,Tecnologia)),
puedeDesarrollarTecnologiaPrevia(TecnologiaRequerida,Jugador).
puedeDesarrollarTecnologia(Tecnologia,Jugador):- tecnologia(Tecnologia),jugador(Jugador),requerimientoTecnologia(Tecnologia,base),not(usaTecnologia(Jugador,Tecnologia)).

puedeDesarrollarTecnologiaPrevia(Tecnologia,Jugador):- tecnologia(Tecnologia),jugador(Jugador),requerimientoTecnologia(Tecnologia,TecnologiaRequerida),
usaTecnologia(Jugador,Tecnologia),puedeDesarrollarTecnologiaPrevia(TecnologiaRequerida,Jugador).

puedeDesarrollarTecnologiaPrevia(Tecnologia,Jugador):-tecnologia(Tecnologia),jugador(Jugador),usaTecnologia(Jugador,Tecnologia).



:- begin_tests(template).

% Punto 2 - grupal
test(experto_en_metales,nondet):-
	expertoEnMetales(ana),expertoEnMetales(beto).

test(no_es_expero_en_metales,fail):-
	expertoEnMetales(carola),expertoEnMetales(dimitri).

% Punto 3 - Juan Mateo

test(civilizacion_es_popular):-
	civilizacionEsPopular(romanos).

	test(civilizacion_es_popular,fail):-
		civilizacionEsPopular(incas).


% Punto 4 - Matias

test(una_tecnologia_tiene_alcance_global):-
	alcanceGlobal(herreria).

test(una_tecnologia_no_tiene_alcance_global,fail):-
	alcanceGlobal(fundicion).

% Punto 5 - David
test(una_civilizacion_es_lider):-
	civilizacionLider(romanos).

test(una_civilizacion_no_es_lider,fail):-
	civilizacionLider(incas).

% Punto 7 - David

test(unidad_con_mas_vida,nondet):-
	unidadConMasVida(ana,jinete(caballo)).

% Punto 8 - Matias
/*
test(quien_gana_si_no_existe_ventaja):-
	quienGana(campeon(100),campeon(50)).

test(quien_gana_si_existe_ventaja,nondet):-
	quienGana(campeon(100),jinete(caballo)).
*/
% Punto 9 - Juan Mateo

test(jugador_sobrevive_asedio):-
	sobreviveAsedio(beto).

	test(jugador_no_sobrevive_asedio,fail):-
		sobreviveAsedio(carola).


% Punto 10 - grupal

test(puede_desarrollar_tecnologia,nondet):-
	puedeDesarrollarTecnologia(molino,beto),
	puedeDesarrollarTecnologia(fundicion,ana).

test(no_puede_desarrollar_tecnologia,fail):-
	puedeDesarrollarTecnologia(herreria,beto).


test(fake_test) :-
	3 is 2 + 1.

:- end_tests(template).