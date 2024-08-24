% Punto 1
comida(hamburguesa,2000).
comida(panchoConPapas,1500).
comida(lomitoCompleto,2500).
comida(caramelos,0).

%atraccion(Tipo)
%tranquila(Nombre,Publico)
%instensa(Nombre,CoeficineteDeLanzamiento)
%montaniaRusa(Nombre,CantidadGirosInvertidos,DuracionEnSegundos)
atraccion(tranquila("Autitos Chocadores",adultosYNinios)).
atraccion(tranquila("La casa embrujada",adultosYNinios)).
atraccion(tranquila("Laberinto",adultosYNinios)).
atraccion(tranquila("Tobogan",ninios)).
atraccion(tranquila("Calesita",ninios)).
atraccion(intensa("El barco Pirata",14)).
atraccion(intensa("Tazas Chinas",6)).
atraccion(intensa("Simulador 3D",2)).
atraccion(montaniaRusa("Abismo Mortal Recargada",3,134)).
atraccion(montaniaRusa("Abismo Mortal Recargada",6,134)).
atraccion(montaniaRusa("Paseo por el bosque",0,45)).
atraccion(acuatica("El torpedo salpicon")).
atraccion(acuatica("Espero que hayas traido una muda de ropa")).

grupo(viejitos).
grupo(losLopez).
grupo(promocion23).

%visitante(Nombre,Edad,Dinero,GrupoFamiliar,Hambre,Aburrimiento).
visitante(eusebio,80,3000,viejitos,50,0).
visitante(carmela,80,0,viejitos,0,25).
visitante(pedro,25,1000,solos,0,0).
visitante(alejandra,30,2600,solos,10,20).

% Punto 2
estadoBienestar(Visitante,Felicidad):-
    visitante(Visitante,_,_,Grupo,Hambre,Aburrimiento),
    felicidad(Grupo,Hambre,Aburrimiento,Felicidad).

felicidad(Grupo,0,0,plena):- Grupo \= solos.
felicidad(Grupo,0,0,podriaEstarMejor):- Grupo=solos.
felicidad(_,Hambre,Aburrimiento,podriaEstarMejor):- 1 =< Hambre + Aburrimiento,50 >= Hambre + Aburrimiento.
felicidad(_,Hambre,Aburrimiento,necesitaEntretenerse):- 51 =< Hambre + Aburrimiento, 99 >= Hambre + Aburrimiento.
felicidad(_,Hambre,Aburrimiento,seQuiereIrACasa):- Hambre + Aburrimiento >= 100.

% Punto 3
/*
Saber si un grupo familiar puede satisfacer su hambre con cierta comida.
 Para que esto ocurra, cada integrante del grupo debe tener dinero suficiente como para comprarse esa comida y 
 esa comida, a la vez, debe poder quitarle el hambre a cada persona. 
 La hamburguesa satisface a quienes tienen menos de 50 de hambre;

  el panchito con papas sólo le quita el hambre a los chicos; 

  y el lomito completo llena siempre a todo el mundo. 
  
  Los caramelos son un caso particular:
   sólo satisfacen a las personas que no tienen dinero suficiente para pagar ninguna otra comida.
*/
satisfaceAlGrupo(Grupo,Comida):-
    grupo(Grupo),
    forall(integrante(Grupo,Nombre),satisface(Nombre,Comida)).

    
integrante(Grupo,Nombre):-
    grupo(Grupo),
    visitante(Nombre,_,_,Grupo,_,_).

satisface(Nombre,Comida):- leAlcanza(Nombre,Comida),quitaElHambre(Nombre,Comida).
satisface(Nombre,caramelos):- 
    forall(comida(Comida,_),not(leAlcanza(Nombre,Comida))).

leAlcanza(Nombre,Comida):-
    comida(Comida,Precio),Comida \= caramelos,visitante(Nombre,_,Dinero,_,_,_), Dinero>Precio.

quitaElHambre(Nombre,hamburguesa):- 
    visitante(Nombre,_,_,_,Hambre,_), Hambre<50.
quitaElHambre(Nombre,panchoConPapas):- 
    visitante(Nombre,Edad,_,_,_,_), Edad<18.
quitaElHambre(_,lomitoCompleto).

% Punto 4

lluviaHamburguesas(Visitante,Atraccion):- visitante(Visitante,_,_,_,_,_), atraccion(Atraccion),
    leAlcanza(Visitante,hamburguesa),criterioAtraccion(Visitante,Atraccion).

criterioAtraccion(_,intensa(_,CoeficineteDeLanzamiento)):- CoeficineteDeLanzamiento > 10.
criterioAtraccion(Visitante,montaniaRusa(_,CantidadGirosInvertidos,_)):- 
    visitante(Visitante,Edad,_,_,_,_),
    Edad > 18,
    not(estadoBienestar(Visitante,necesitaEntretenerse)),
    mayorCantidadGiros(CantidadGirosInvertidos).
criterioAtraccion(Visitante,montaniaRusa(_,_,Duracion)):- 
    visitante(Visitante,Edad,_,_,_,_),
    Edad < 18,
    Duracion < 60.
criterioAtraccion(Visitante,tranquila("Tobogan",_)):- visitante(Visitante,Edad,_,_,_,_),Edad<18.


cantidadGirosInvertidos(CantidadGirosInvertidos):-atraccion(montaniaRusa(_,CantidadGirosInvertidos,_)).
mayorCantidadGiros(MayorCantidadGiros):-atraccion(montaniaRusa(_,MayorCantidadGiros,_)),
    forall(cantidadGirosInvertidos(CantidadGirosInvertidos),MayorCantidadGiros>=CantidadGirosInvertidos).